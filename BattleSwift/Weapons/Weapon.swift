//
//  Weapon.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

// Weapon parent class
class Weapon {
    var power = 0
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
}
