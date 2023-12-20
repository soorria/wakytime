//
//  WakeTimes.swift
//  SickCounter
//
//  Created by mooth on 16/12/2023.
//

import SwiftUI

struct WakeTimeInfo {
    let wakeTime: String
    let sleepDuration: String
    let cycleCount: Int
}

struct WakeTimesView: View {
    private let sleepTime = Date()
    private let sleepCycleSeconds = 90 * 60
    private let hourInSeconds = 60 * 60

    @State private var animateCircles = false
    @State private var glowAnimation = false

    private var wakeTimes: [WakeTimeInfo] {
        (1...6).compactMap { cycle in
            guard let wakeTimeDate = Calendar.current.date(byAdding: .second, value: sleepCycleSeconds * cycle, to: sleepTime) else {
                return nil
            }
            let wakeTime = wakeTimeDate.formatted(date: .omitted, time: .shortened)
            let sleepDuration = (Double(sleepCycleSeconds * cycle) / Double(hourInSeconds)).formatted()
            return WakeTimeInfo(wakeTime: wakeTime, sleepDuration: sleepDuration, cycleCount: cycle)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(wakeTimes, id: \.cycleCount) { wakeTimeInfo in
                WakeTimeRow(wakeTimeInfo: wakeTimeInfo, animateCircles: $animateCircles, glowAnimation: $glowAnimation)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animateCircles = true
                glowAnimation = true
            }
        }
    }
}

struct WakeTimeRow: View {
    let wakeTimeInfo: WakeTimeInfo
    @Binding var animateCircles: Bool
    @Binding var glowAnimation: Bool

    var body: some View {
        HStack(spacing: 20) {
            WakeTimeCircle(wakeTimeInfo: wakeTimeInfo, animateCircles: animateCircles, glowAnimation: glowAnimation)

            HStack {
                Text("\(wakeTimeInfo.wakeTime)")
                    .dynamicTypeSize(.xxxLarge)
                    .multilineTextAlignment(.leading)

                Spacer()

                Text("\(wakeTimeInfo.sleepDuration) hrs")
                    .dynamicTypeSize(.small)
            }
            .frame(width: 160)

            Button(action: {}) {
                Image(systemName: "alarm.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
            }
        }
    }
}

struct WakeTimeCircle: View {
    let wakeTimeInfo: WakeTimeInfo
    let animateCircles: Bool
    let glowAnimation: Bool

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: animateCircles ? min(Double(5), Double(wakeTimeInfo.cycleCount)) / 5 : 0)
                .stroke(getCycleColor(wakeTimeInfo.cycleCount), lineWidth: 2)
                .frame(width: 25, height: 25)
                .rotationEffect(.degrees(-90))
                .animation(animateCircles ? .easeInOut(duration: 0.15 * Double(wakeTimeInfo.cycleCount)).delay(0.05 * Double(wakeTimeInfo.cycleCount - 1)) : .default, value: animateCircles)

            if wakeTimeInfo.cycleCount == 6 {
                Circle()
                    .trim(from: 0.0, to: animateCircles ? 1 : 0)
                    .stroke(getCycleColor(wakeTimeInfo.cycleCount), lineWidth: 2)
                    .frame(width: 25, height: 25)
                    .shadow(color: getCycleColor(wakeTimeInfo.cycleCount).opacity(glowAnimation ? 1 : 0), radius: glowAnimation ? 10 : 0, x: 0, y: 0)
                    .animation(glowAnimation ? Animation.easeInOut(duration: 1).delay(0.25).repeatForever(autoreverses: true) : .default, value: glowAnimation)
            }

            Text("\(wakeTimeInfo.cycleCount)").dynamicTypeSize(.small)
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


#Preview {
    WakeTimesView()
}
