//
//  Mace.swift
//  BattleSwift
//
//  Created by Co5ta on 28/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

// Colossus weapon
class Mace: Weapon {
    
    init(level: Int = 1) {
        super.init()
        if let weapon: MaceLevel = MaceLevel(rawValue: level) {
            switch weapon {
            case .Aries:
                power = 5
            case .Taurus:
                power = 7
            case .Gorilla:
                power = 10
            case .Rhino:
                power = 15
            }
        }
    }
    
}

// All types of axe available
enum MaceLevel: Int {
    case Aries = 1, Taurus, Gorilla, Rhino
}
