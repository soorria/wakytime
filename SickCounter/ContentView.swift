//
//  ContentView.swift
//  SickCounter
//
//  Created by mooth on 16/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var startTime = Date()
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var themeManager = ThemeManager.shared


    var body: some View {
        NavigationStack {
            ZStack {
                colorScheme == .dark ? Color.base300.edgesIgnoringSafeArea(.all) : nil
                NavigationLink(destination: WakeTimesView()) {
                    Text("Go to sleep now")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .background(themeManager.primary)
                        .cornerRadius(10)
                }
                .navigationTitle("WakeyTime")

            }
            
        }
    }
}

#Preview {
    ContentView()
}
