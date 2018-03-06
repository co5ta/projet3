//
//  Character.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// A *Character* object represents a warrior in a *Team*
class Character {
    
    /// The name of the character
    var name: String
    
    /// The type of the Character (Fighter, Mage, Colossus, ...)
    var type: CharacterType
    
    /// The weapon used by the Character
    var weapon: Weapon
    
    /// The maximum number of life points a Character can have
    let lifeMax: Int
    
    /// The number of life points remaining to the Character
    var life: Int
    
    /// A Boolean indicating if the Character is dead or alive
    var isDead = false
    
    /// A Boolean indicating if the Character gained a bonus weapon
    var weaponUpdated = false
    
    /// Initialize a Character
    init(name: String, type: CharacterType) {
        self.name = name.uppercased()
        self.type = type
        
        switch type {
        case .Fighter:
            lifeMax = 100
            weapon = Sword()
        case .Mage:
            lifeMax = 110
            weapon = Ring()
        case .Colossus:
            lifeMax = 180
            weapon = Mace()
        case .Dwarf:
            lifeMax = 80
            weapon = Axe()
        case .Assassin:
            lifeMax = 90
            weapon = Knife()
        }
        
        life = lifeMax
    }
    
    /// Return a String giving the name, the type, the strength and the remaining life of the Character
    func description() -> String {
        return "\(name) (\(type), \(weapon.power) \(weapon.className != "Ring" ? "ATK" : "DEF"), \(life) PV)"
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
        if life > lifeMax {
            life = lifeMax
            print("He's life is at max level")
        }
    }
}

/// All types of Character available
enum CharacterType: Int, CaseCountable {
    case Fighter, Mage, Colossus, Dwarf, Assassin
}
