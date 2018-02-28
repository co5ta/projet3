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
    
    init(level: Int =  1) {
        super.init()
        if let weapon: AxeLevel = AxeLevel(rawValue: level) {
            switch weapon {
            case .Scopper:
                power = 20
            case .Silver:
                power = 22
            case .Golden:
                power = 26
            case .Diamond:
                power = 30
            }
        }
    }
    
}

// All types of axe available
enum AxeLevel: Int {
    case Scopper = 1, Silver, Golden, Diamond
}
