//
//  Color+CycleColours.swift
//  SickCounter
//
//  Created by Eric Paul on 20/12/2023.
//

import SwiftUI

extension Color {
    static func cycleColor(for cycle: Int) -> Color {
        let maxCycle = 5
        let minHue: CGFloat = 0 // Red
        let maxHue: CGFloat = 1 / 3 // Green

        let normalizedCycle = max(1, min(cycle, maxCycle))
        let hue = minHue + (maxHue - minHue) * CGFloat(normalizedCycle - 1) / CGFloat(maxCycle - 1)

        return Color(hue: Double(hue), saturation: 1.0, brightness: 1.0)
    }
}
