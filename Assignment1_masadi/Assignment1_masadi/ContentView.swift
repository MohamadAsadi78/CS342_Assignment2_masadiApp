//
//  ContentView.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/12/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(PatientStore.self) var patientStore // Using the Environment to use the patientStore from the upper view in the new way (I used the migration to Observable doc of Swift

    var body: some View {
        PatientListView() // Main patient list view
    }
}

#Preview {
    ContentView()
        .environment(PatientStore())
}
