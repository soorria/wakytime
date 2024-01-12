//
//  WakeTimeRow.swift
//  SickCounter
//
//  Created by Eric Paul on 20/12/2023.
//

import SwiftUI

struct WakeTimeRow: View {
    let wakeTimeInfo: WakeTimeInfo
    @Binding var animateCircles: Bool
    @Binding var glowAnimation: Bool
    @ObservedObject var themeManager = ThemeManager.shared
    
    var body: some View {
        HStack(spacing: 20) {
            WakeTimeCircle(wakeTimeInfo: wakeTimeInfo, animateCircles: animateCircles, glowAnimation: glowAnimation)

            Text("\(wakeTimeInfo.wakeTime)")
                .dynamicTypeSize(.xxxLarge)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(wakeTimeInfo.sleepDuration) hrs")
                .dynamicTypeSize(.small)
            
            Button(action: {}) {
                Image(systemName: "alarm.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(themeManager.base100)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}
