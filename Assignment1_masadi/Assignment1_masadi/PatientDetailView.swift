//
//  PatientDetailView.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/20/25.
//
import SwiftUI

struct PatientDetailView: View {
    var patient: Patient
    @State private var isPrescribingMedication = false // Boolean for PrescribeMedication sheet

    var body: some View {
        List {
            Section(header: Text("Patient Details")) { // Showing the patient's details
                Text("Full Name: \(patient.fullNameWithAge())")
                Text("Height: \(patient.height, specifier: "%.1f") cm")
                Text("Weight: \(patient.weight, specifier: "%.1f") kg")
                if let bloodType = patient.bloodType {
                    Text("Blood Type: \(bloodType.rawValue)")
                } else {
                    Text("Blood Type: Unknown")
                }
            }
            
            Section(header: Text("Medications")) {
                if patient.currentMedications().isEmpty {
                    Text("No active medications.")
                } else {
                    ForEach(patient.currentMedications(), id: \.datePrescribed) { medication in
                        Text(medication.description)
                    }
                }
            }
        }
        .navigationTitle("Patient Details")
        .toolbar {
            Button("Prescribe Medication") {
                isPrescribingMedication = true
            }
        }
        .sheet(isPresented: $isPrescribingMedication) { // The sheet comes up everytime we put its binding boolean true (by hitting the button)
            PrescribeMedicationView(patient: patient)
        }
    }
}
