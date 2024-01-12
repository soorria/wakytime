//
//  WakeTimeCircle.swift
//  SickCounter
//
//  Created by Eric Paul on 20/12/2023.
//

import SwiftUI

struct WakeTimeCircle: View {
    let wakeTimeInfo: WakeTimeInfo
    let animateCircles: Bool
    let glowAnimation: Bool

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: animateCircles ? min(Double(5), Double(wakeTimeInfo.cycleCount)) / 5 : 0)
                .stroke(Color.cycleColor(for: wakeTimeInfo.cycleCount), lineWidth: 2)
                .frame(width: 25, height: 25)
                .rotationEffect(.degrees(-90))
                .animation(animateCircles ? .easeInOut(duration: 0.15 * Double(wakeTimeInfo.cycleCount)).delay(0.05 * Double(wakeTimeInfo.cycleCount - 1)) : .default, value: animateCircles)

            if wakeTimeInfo.cycleCount == 6 {
                Circle()
                    .trim(from: 0.0, to: animateCircles ? 1 : 0)
                    .stroke(Color.cycleColor(for: wakeTimeInfo.cycleCount), lineWidth: 2)
                    .frame(width: 25, height: 25)
                    .shadow(color: getCycleColor(wakeTimeInfo.cycleCount).opacity(glowAnimation ? 1 : 0), radius: glowAnimation ? 10 : 0, x: 0, y: 0)
                    .animation(glowAnimation ? Animation.easeInOut(duration: 1).delay(0.25).repeatForever(autoreverses: true) : .default, value: glowAnimation)
            }

            Text("\(wakeTimeInfo.cycleCount)").dynamicTypeSize(.small).fontWeight(.heavy)
        }
    }

    private func getCycleColor(_ cycle: Int) -> Color {
        let maxCycle = 5
        let minHue: CGFloat = 0 // Red
        let maxHue: CGFloat = 1 / 3 // Green

        // Ensure the cycle value is within the expected range
        let normalizedCycle = max(1, min(cycle, maxCycle))

        // Calculate the hue value based on the cycle
        let hue = minHue + (maxHue - minHue) * CGFloat(normalizedCycle - 1) / CGFloat(maxCycle - 1)

        // Create and return the color
        return Color(hue: Double(hue), saturation: 1.0, brightness: 1.0)
    }

}
