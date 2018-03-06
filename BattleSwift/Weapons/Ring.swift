//
//  Ring.swift
//  BattleSwift
//
//  Created by Co5ta on 28/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// Weapon of the Mage
class Ring: Weapon {
    
    /// Initialize a Weapon of type Ring
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

/// All types of Ring available
enum RingLevel: Int, CaseCountable {
    case Druid, Archmage, Merlin
}
