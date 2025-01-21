//
//  PatientStore.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/20/25.
//

import SwiftUI

@Observable
class PatientStore {
    // Automatically observable property for the list of patients
    var patients: [Patient] = []

    // Method to add a new patient to the list
    func addPatient(_ patient: Patient) {
        patients.append(patient) // Add the new patient to the array
    }
}
