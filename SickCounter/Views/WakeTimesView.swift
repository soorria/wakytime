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
    private let timeToSleep = 60 * 15
    
    @Environment(\.colorScheme) var colorScheme
    @State private var animateCircles = false
    @State private var glowAnimation = false

    private var wakeTimes: [WakeTimeInfo] {
        (1...6).compactMap { cycle in
            guard let wakeTimeDate = Calendar.current.date(byAdding: .second, value: sleepCycleSeconds * cycle + timeToSleep, to: sleepTime) else {
                return nil
            }
            let wakeTime = wakeTimeDate.formatted(date: .omitted, time: .shortened)
            let sleepDuration = (Double(sleepCycleSeconds * cycle) / Double(hourInSeconds)).formatted()
            return WakeTimeInfo(wakeTime: wakeTime, sleepDuration: sleepDuration, cycleCount: cycle)
        }
    }

    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.base300.edgesIgnoringSafeArea(.all) : nil
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("You should wake up at...")
                        .bold()
                        .dynamicTypeSize(.xxxLarge)
                        .foregroundColor(.primary)
                        .padding(.top, 20)

                    Text("This accounts for you taking 15 minutes to sleep")
                        .italic()
                        .dynamicTypeSize(.small)
                        .opacity(0.5)
                        .padding(.top, 5)
                }
                .frame(maxWidth: .infinity, alignment: .leading) // Aligns the VStack content to the leading edge
                .padding() // Adds padding around the VStack
                
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
                .padding()
            }
        }
    }
}


#Preview {
    WakeTimesView()
}
