//
//  Ring.swift
//  BattleSwift
//
//  Created by Co5ta on 28/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

// Mage's weapon
class Ring: Weapon {
    
    init(level: Int = 1) {
        super.init()
        if let weapon: RingLevel = RingLevel(rawValue: level) {
            switch weapon {
            case .Druid:
                power = 15
            case .Archmage:
                power = 20
            case .Merlin:
                power = 30
            }
        }
    }
    
}

// All types of ring available
enum RingLevel: Int {
    case Druid = 1, Archmage, Merlin
}
