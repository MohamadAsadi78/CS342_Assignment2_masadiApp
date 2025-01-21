//
//  Patient.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/12/25.
//

import Foundation
import SwiftUI

@Observable
class Patient {
    // Static property for generating unique MedicalRecordNumbers
    // private static var nextMedicalRecordNumber = 1 Replacing this with UUID

    // Instance properties
    let medicalRecordNumber: UUID
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var height: Double // in cm
    var weight: Double // in kg
    var bloodType: BloodType? // Optional blood type
    var medications: [Medication] = []

    // Initialization
    init(
        firstName: String,
        lastName: String,
        dateOfBirth: Date,
        height: Double,
        weight: Double,
        bloodType: BloodType? = nil
    ) {
        self.medicalRecordNumber = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
    }

    // Method to calculate the patient's age
    func calculateAge() -> Int {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year], from: dateOfBirth, to: now)
        return components.year ?? 0
    }

    // Method to return the patient’s full name and age
    func fullNameWithAge() -> String {
        "\(lastName), \(firstName) (\(calculateAge()))"
    }

    // Method to return a list of current medications
    func currentMedications() -> [Medication] {
        medications.filter { !$0.isCompleted }.sorted { $0.datePrescribed > $1.datePrescribed }
    }

    // Method to prescribe a new medication
    func prescribeMedication(_ newMedication: Medication) throws {
        if medications.contains(where: {
            $0.name == newMedication.name &&
            !$0.isCompleted
        }) {
            throw MedicationError.duplicateMedication
        }
        medications.append(newMedication)
    }

    // Method to determine compatible donor blood types
    func compatibleDonorBloodTypes() -> [BloodType]? {
        guard let bloodType = bloodType else { return nil }
        return bloodType.compatibleDonors()
    }
}

// MedicationError enum remains unchanged
enum MedicationError: Error, CustomStringConvertible {
    case duplicateMedication
    
    var description: String {
        switch self {
        case .duplicateMedication:
            return "The medication is already prescribed and active."
        }
    }
}
