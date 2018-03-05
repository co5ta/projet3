//
//  Axe.swift
//  BattleSwift
//
//  Created by Co5ta on 28/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// Weapon of the Dwarf
class Axe: Weapon {
    
    /// Initialize a Weapon of type Axe
    init(level: Int = 0) {
        super.init()
        if let weapon: AxeLevel = AxeLevel(rawValue: level) {
            switch weapon {
            case .Scopper:
                power = 15
            case .Silver:
                power = 18
            case .Golden:
                power = 23
            case .Diamond:
                power = 28
            }
        }
    }
    
}

/// All types of Axe available
enum AxeLevel: Int {
    case Scopper, Silver, Golden, Diamond
    
    /// Return the numbers of cases available in the Enum
    static let count: Int = {
        var max = 0
        while let _ = AxeLevel(rawValue: max) { max += 1 }
        return max
    }()
}
