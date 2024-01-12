//
//  SickCounterApp.swift
//  SickCounter
//
//  Created by mooth on 16/12/2023.
//

import SwiftUI

@main
struct SickCounterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ThemeManager.shared)
        }
    }
}
