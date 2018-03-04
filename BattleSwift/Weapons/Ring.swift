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
    
    init(level: Int = 0) {
        super.init()
        if let weapon: RingLevel = RingLevel(rawValue: level) {
            switch weapon {
            case .Druid:
                power = 9
            case .Archmage:
                power = 13
            case .Merlin:
                power = 16
            }
        }
    }
    
}

// All types of ring available
enum RingLevel: Int {
    case Druid, Archmage, Merlin
    
    static let count: Int = {
        var max = 0
        while let _ = RingLevel(rawValue: max) { max += 1 }
        return max
    }()
}
