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

// All types of sword available
enum SwordLevel: Int {
    case Heavy, Musketeer, Justice, Damoclès, Excalibur
    
    static let count: Int = {
        var max = 0
        while let _ = SwordLevel(rawValue: max) { max += 1 }
        return max
    }()
}
