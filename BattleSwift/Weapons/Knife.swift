//
//  Knife.swift
//  BattleSwift
//
//  Created by Co5ta on 05/03/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// Weapon of the Assassin
class Knife: Weapon {
    
    /// Initialize a Weapon of type Knife
    init(level: Int = 0) {
        super.init()
        if let weapon: KnifeLevel = KnifeLevel(rawValue: level) {
            switch weapon {
            case .Venom:
                power = 8
            case .Toxin:
                power = 11
            case .Cyanide:
                power = 14
            }
        }
    }
}

/// All types of Knife available
enum KnifeLevel: Int {
    case Venom, Toxin, Cyanide
    
    /// Return the numbers of cases available in the Enum
    static var count: Int {
        var max = 0
        while let _ = KnifeLevel(rawValue: max) { max += 1 }
        return max
    }
}