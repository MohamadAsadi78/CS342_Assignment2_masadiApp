//
//  Assignment1_masadiApp.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/12/25.
//

import SwiftUI

@main
struct Assignment1_masadiApp: App {
    @State private var patientStore = PatientStore() // PatientStore as a State to keep track of it in all views

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(patientStore) // Inject the shared instance into the environment
        }
    }
}
