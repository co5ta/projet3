//
//  Character.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

struct Character {
    var name: String
    var type: Type
    var weapon: Weapon
    var life: Int
}

enum Type: Int {
    case Fighter = 1
    case Mage
    case Colossus
    case Dwarf
}
