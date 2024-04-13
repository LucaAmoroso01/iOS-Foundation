//
//  Colors.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 12/04/2024.
//

import SwiftUI

enum Colors {
    case darkGreen
}

func setColor(color: Colors) -> Any {
    if color === Colors.darkGreen {
        return Color(red: 27/255, green: 51/255, blue: 28/255)
    }
}
