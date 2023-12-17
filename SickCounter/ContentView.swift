//
//  ContentView.swift
//  SickCounter
//
//  Created by mooth on 16/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var startTime = Date()

    var body: some View {
        NavigationStack {
            NavigationLink("Go to sleep now") {
                WakeTimesView()
            }
            .navigationTitle("WakeyTime")
        }
    }
}

#Preview {
    ContentView()
}
