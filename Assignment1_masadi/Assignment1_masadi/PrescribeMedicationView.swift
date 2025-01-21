//
//  PrescribeMedicationView.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/20/25.
//
import SwiftUI

struct PrescribeMedicationView: View {
    var patient: Patient
    @Environment(\.dismiss) private var dismiss // Using dismiss to easily close the sheet

    @State private var name = ""
    @State private var dose = ""
    @State private var route = ""
    @State private var frequency = ""
    @State private var duration = ""
    @State private var showError = false

    var body: some View {
        NavigationStack {
            Form {
                TextField("Medication Name", text: $name)
                TextField("Dose (e.g., 500mg)", text: $dose)
                TextField("Route (e.g., oral)", text: $route)
                TextField("Frequency (times per day)", text: $frequency)
                    .keyboardType(.numberPad)
                TextField("Duration (days)", text: $duration)
                    .keyboardType(.numberPad)
                
                if showError {
                    Text("Duplicate or invalid medication.")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Prescribe Medication")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        prescribeMedication()
                    }
                    .disabled(!isFormValid())
                }
            }
        }
    }
    
    private func isFormValid() -> Bool { // Checking whether the form is valid, will save only in this condition
        guard !name.isEmpty, !dose.isEmpty, !route.isEmpty,
              let _ = Int(frequency), let _ = Int(duration) else {
            return false
        }
        return true
    }
    
    private func prescribeMedication() {
        guard let frequencyValue = Int(frequency),
              let durationValue = Int(duration) else { return }
        
        let newMedication = Medication(
            datePrescribed: Date(),
            name: name,
            dose: dose,
            route: route,
            frequency: frequencyValue,
            duration: durationValue
        )
        
        do {
            try patient.prescribeMedication(newMedication) // I use the same method for checking duplications as in Assignment 1
            dismiss() // Will close if no duplication error
        } catch {
            showError = true
        }
    }
}
