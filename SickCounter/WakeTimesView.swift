//
//  WakeTimes.swift
//  SickCounter
//
//  Created by mooth on 16/12/2023.
//

import SwiftUI

struct WakeTimesView: View {
    private let sleepTime = Date()
    private let sleepCycleSeconds = 90 * 60
    private let hourInSeconds = 60 * 60
    @State private var animateCircles = true
    @State private var glowAnimation = false

    typealias WakeTimeInfo = (wakeTime: String, sleepDuration: String, cycleCount: Int)

    private var wakeTimes: [WakeTimeInfo] {
        (1 ... 6).compactMap { (cycle: Int) -> WakeTimeInfo? in
            let secondsToAdd = sleepCycleSeconds * cycle

            let wakeTime = Calendar.current.date(
                byAdding: .second,
                value: secondsToAdd,
                to: sleepTime
            )?.formatted(date: .omitted, time: .shortened)

            guard wakeTime != nil else {
                return nil
            }

            let sleepDuration = (Double(secondsToAdd) / Double(hourInSeconds)).formatted()

            return (wakeTime!, sleepDuration, cycle)
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

    @State var c = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(wakeTimes, id: \.cycleCount) { wakeTimeInfo in
                HStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .trim(from: 0.0, to: animateCircles ? min(Double(5), Double(wakeTimeInfo.cycleCount)) / 5 : 0)
                            .stroke(getCycleColor(wakeTimeInfo.cycleCount), lineWidth: 2)
                            .frame(width: 25, height: 25)
                            .rotationEffect(.degrees(-90))
                            .animation(Animation.easeInOut(duration: 0.15 * Double(wakeTimeInfo.cycleCount)).delay(0.05 * Double(wakeTimeInfo.cycleCount - 1)), value: animateCircles)

                        if wakeTimeInfo.cycleCount == 6 {
                            Circle()
                                .trim(from: 0.0, to: animateCircles ? 1 : 0)
                                .stroke(getCycleColor(wakeTimeInfo.cycleCount), lineWidth: 2)
                                .frame(width: 25, height: 25)
                                .shadow(color: getCycleColor(wakeTimeInfo.cycleCount).opacity(glowAnimation ? 1 : 0), radius: glowAnimation ? 10 : 0, x: 0, y: 0)
                                .animation(Animation.easeInOut(duration: 1).delay(0.25).repeatForever(autoreverses: true), value: glowAnimation)
                        }

                        Text("\(wakeTimeInfo.cycleCount)").dynamicTypeSize(.small)
                    }

                    HStack {
                        Text("\(wakeTimeInfo.wakeTime)")
                            .dynamicTypeSize(.xxxLarge)
                            .multilineTextAlignment(.leading)

                        Spacer()

                        Text("\(wakeTimeInfo.sleepDuration) hrs")
                            .dynamicTypeSize(.small)

                    }.frame(width: 160)

                    Button(action: {}) {
                        Image(systemName: "alarm.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .onAppear {
            animateCircles = true
            glowAnimation = true
        }
    }
}

#Preview {
    WakeTimesView()
}
