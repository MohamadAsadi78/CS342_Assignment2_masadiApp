//
//  NewPatientForm.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/20/25.
//
import SwiftUI

struct NewPatientForm: View {
    @Environment(PatientStore.self) var patientStore // Access shared PatientStore
    @Environment(\.dismiss) private var dismiss // To easily close the current sheet
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date()
    @State private var height = ""
    @State private var weight = ""
    @State private var bloodType: BloodType? = nil
    @State private var showValidationError = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Required Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(.wheel) // Force the wheel style
                        .accessibilityIdentifier("dateOfBirthPicker")
                    TextField("Height (cm)", text: $height).keyboardType(.decimalPad)
                    TextField("Weight (kg)", text: $weight).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Optional Information")) {
                    Picker("Blood Type", selection: $bloodType) {
                        Text("Unknown").tag(BloodType?.none)
                        ForEach(BloodType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type as BloodType?)
                        }
                    }
                }
                
                if showValidationError {
                    Text("Please fill out all required fields correctly.")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("New Patient")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") { savePatient() }
                        .disabled(!isFormValid())
                }
            }
        }
    }
    
    private func isFormValid() -> Bool {
        guard !firstName.isEmpty, !lastName.isEmpty,
              let _ = Double(height), let _ = Double(weight) else { return false }
        return true
    }
    
    private func savePatient() {
        guard let heightValue = Double(height),
              let weightValue = Double(weight) else { return }
        
        let newPatient = Patient(
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            height: heightValue,
            weight: weightValue,
            bloodType: bloodType
        )
        patientStore.addPatient(newPatient) // Add patient to the shared PatientStore
        dismiss() // Close the form
    }
}

