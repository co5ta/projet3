//
//  Mace.swift
//  BattleSwift
//
//  Created by Co5ta on 28/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// Weapon of the Colossus
class Mace: Weapon {
    
    /// Initialize a Weapon of type Mace
    init(level: Int = 0) {
        super.init()
        if let weapon: MaceLevel = MaceLevel(rawValue: level) {
            switch weapon {
            case .Aries:
                power = 7
            case .Taurus:
                power = 10
            case .Gorilla:
                power = 14
            case .Rhino:
                power = 19
            }
        }
    }
    
}

/// All types of Mace available
enum MaceLevel: Int, CaseCountable {
    case Aries, Taurus, Gorilla, Rhino
}
