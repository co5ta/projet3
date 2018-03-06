//
//  Sword.swift
//  BattleSwift
//
//  Created by Co5ta on 28/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// Weapon of the Fighter
class Sword: Weapon {
    
    /// Initialize a Weapon of type Sword
    init(level: Int = 0) {
        super.init()
        if let weapon: SwordLevel = SwordLevel(rawValue: level) {
            switch weapon {
            case .Heavy:
                power = 10
            case .Musketeer:
                power = 13
            case .Justice:
                power = 16
            case .Damoclès:
                power = 19
            case .Excalibur:
                power = 25
            }
        }
    }
    
}

/// All types of Sword available
enum SwordLevel: Int, CaseCountable {
    case Heavy, Musketeer, Justice, Damoclès, Excalibur
}
