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
    var type: CharacterType
    var weapon: Weapon
    var life: Int
    
    init(name: String, type: CharacterType) {
        self.name = name
        self.type = type
        
        switch type {
        case .Fighter:
            self.life = 100
            self.weapon = Weapon(damage: 10)
        case .Mage:
            self.life = 150
            self.weapon = Weapon(damage: 10)
        case .Colossus:
            self.life = 110
            self.weapon = Weapon(damage: 10)
        case .Dwarf:
            self.life = 90
            self.weapon = Weapon(damage: 10)
        }
        
    }
    
    func description() -> String {
        return "\(name) (\(type), \(life) PV)"
    }
}

enum CharacterType: Int {
    case Fighter = 1
    case Mage
    case Colossus
    case Dwarf // Must stay the last case to keep the good value in count var
    
    // Pay again attention that we must use the last enum case to built this var
    static var count: Int = CharacterType.Dwarf.rawValue
}
