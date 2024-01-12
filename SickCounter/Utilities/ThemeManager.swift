//
//  ThemeManager.swift
//  SickCounter
//
//  Created by Eric Paul on 20/12/2023.
//

import SwiftUI

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()

    var primary: Color { Color("Primary") }
    var secondary: Color { Color("Secondary") }
    var accent: Color { Color("Accent") }
    var neutral: Color { Color("Neutral") }
    var neutralContent: Color { Color("NeutralContent") }
    var base100: Color { Color("Base-100") }
    var base200: Color { Color("Base-200") }
    var base300: Color { Color("Base-300") }
    var baseContent: Color { Color("BaseContent") }
    var info: Color { Color("Info") }
    var success: Color { Color("Success") }
    var warning: Color { Color("Warning") }
    var error: Color { Color("Error") }

}
