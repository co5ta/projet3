//
//  Axe.swift
//  BattleSwift
//
//  Created by Co5ta on 28/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

// Dwarf weapon
class Axe: Weapon {
    
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

// All types of axe available
enum AxeLevel: Int {
    case Scopper, Silver, Golden, Diamond
    
    static let count: Int = {
        var max = 0
        while let _ = AxeLevel(rawValue: max) { max += 1 }
        return max
    }()
}
