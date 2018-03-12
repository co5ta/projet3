//
//  Character.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// Minimum value that can have the lifeMax property of the Character
let minValueCharacterLifeMax = 0

/// A *Character* object represents a warrior in a *Team*
class Character {
    /// The name of the character
    var name: String
    
    /// The type of the Character (Fighter, Mage, Colossus, ...)
    var type: CharacterType
    
    /// The weapon used by the Character
    var weapon: Weapon
    
    /// The number of life points remaining to the Character
    var life: Int
    
    /// The status of the Character
    var status: [WeaponEffect: Int] = [:]
    
    /// A Boolean indicating if the Character is dead or alive
    var isDead = false
    
    /// A Boolean indicating if the Character gained a bonus weapon
    var weaponUpdated = false
    
    /// Initialize a Character
    init(name: String, type: CharacterType) {
        self.name = name.uppercased()
        self.type = type
        self.life = type.lifeMax
        weapon = WeaponFactory.giveWeapon(toCharacterOfType: type)
        
    }
    
    /// Return a String giving the name, the type, the strength and the remaining life of the Character
    func description() -> String {
        var text = "\(name) "
        if (!status.isEmpty) {
            for (key, _) in status {
              text += "[\(key)] "
            }
        }
        text += "(\(type), \(weapon.power) \(weapon is Ring ? "DEF" : "ATK"), \(life) PV)"
        return text
    }
    
    /// Remove some life points from the Character
    func receiveDamage(from enemy: Character) {
        let damage = enemy.weapon.power
        life -= damage
        
        print("\n\(enemy.name) attacks \(name) !")
        print("\(name) looses \(damage) PV")
        
        // life can't be lower than 0
        if life <= 0 {
            life = 0
            isDead = true
            status = [:]
            print("\(name) is dead !")
        }
    }
    
    /// Add some life points from the Character
    func getHealed(by partner: Character) {
        let healing = partner.weapon.power
        life += healing
        
        print("\n\(partner.name) heals \(name)")
        print("\(name) gains \(healing) PV")
        
        // life can't be higher than lifeMax
        if life > type.lifeMax {
            life = type.lifeMax
            print("His life is at max level")
        }
        
        if status.isEmpty == false {
            status = [:]
            print("And he's healed")
        }
    }
}

/// CharacterType contains the type differents type of Character available in the game
enum CharacterType: Int, CaseCountable {
    /// Type of Character available
    case Fighter, Colossus, Dwarf, Assassin, Mage
    
    /// Return the maximum life a Character can have, depending his type
    var lifeMax: Int {
        switch self {
        case .Fighter:
            return minValueCharacterLifeMax + 50    // 100
        case .Colossus:
            return minValueCharacterLifeMax + 75    // 125
        case .Dwarf:
            return minValueCharacterLifeMax + 25    // 75
        case .Assassin:
            return minValueCharacterLifeMax + 40    // 90
        case .Mage:
            return minValueCharacterLifeMax + 30    // 80
        }
    }
}
