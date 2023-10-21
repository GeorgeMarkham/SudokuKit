//
//  Difficulty.swift
//
//
//  Created by George on 21/10/2023.
//

import Foundation

public enum Difficulty {
    case easy, medium, hard
    
    // Not an exact science but this should create some interesting boards
    internal var numHolesRange: ClosedRange<Int> {
        switch self {
        case .easy:
            37...45
        case .medium:
            45...55
        case .hard:
            55...60
        }
    }
}
