//
//  PatientListView.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/20/25.
//
import SwiftUI

struct PatientListView: View {
    @Environment(PatientStore.self) var patientStore // Access shared PatientStore from the environment using the 'after migration' method
    @State private var searchText = "" // Search text is going to be kept at all times unless removed by user
    @State private var isAddingPatient = false // The boolean needed as the binding of the NewPatientForm sheet

    var body: some View {
        NavigationStack { // Using NavigationStack as per the requirement
            List {
                ForEach(filteredPatients, id: \.medicalRecordNumber) { patient in
                    NavigationLink(destination: PatientDetailView(patient: patient)) { // Using a NavigationLink for each patient, containing the required texts
                        VStack(alignment: .leading) {
                            Text("\(patient.lastName), \(patient.firstName)")
                                .font(.headline)
                            Text("Age: \(patient.calculateAge()) \nMRN: \(patient.medicalRecordNumber)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Patients")
            .toolbar {
                Button(action: {
                    isAddingPatient = true
                }) {
                    Label("Add Patient", systemImage: "plus")
                }
            }
            .sheet(isPresented: $isAddingPatient) {
                NewPatientForm()
            }
            .searchable(text: $searchText, prompt: "Search by last name")
        }
    }
    
    var filteredPatients: [Patient] {
        if searchText.isEmpty {
            return patientStore.patients.sorted { $0.lastName < $1.lastName } // Sorting by last name
        } else {
            return patientStore.patients
                .filter { $0.lastName.lowercased().contains(searchText.lowercased()) } // Only searching in last names, as required
                .sorted { $0.lastName < $1.lastName } // Again sorting the search (basically filtering) results
        }
    }
}
