//
//  Sword.swift
//  BattleSwift
//
//  Created by Co5ta on 28/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

// Fighter's weapon
class Sword: Weapon {
    
    init(level: Int = 1) {
        super.init()
        if let weapon: SwordLevel = SwordLevel(rawValue: level) {
            switch weapon {
            case .Heavy:
                power = 10
            case .Musketeer:
                power = 13
            case .Justice:
                power = 15
            case .Damoclès:
                power = 18
            case .Excalibur:
                power = 25
            }
        }
    }
    
}

// All types of sword available
enum SwordLevel: Int {
    case Heavy = 1, Musketeer, Justice, Damoclès, Excalibur
}
