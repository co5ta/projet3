//
//  Weapon.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// Weapons parent class
class Weapon {
    
    /// The power of the weapon represents number of life points it will add or remove to the enemy
    var power = 0
    
    /// Return the name of the class
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
}
