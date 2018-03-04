//
//  Character.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

class Character {
    var name: String
    var type: CharacterType
    var weapon: Weapon
    let lifeMax: Int
    var life: Int
    var isDead = false
    var weaponUpdated = false
    
    init(name: String, type: CharacterType) {
        self.name = name.uppercased()
        self.type = type
        
        switch type {
        case .Fighter:
            lifeMax = 100
            weapon = Sword()
        case .Mage:
            lifeMax = 90
            weapon = Ring()
        case .Colossus:
            lifeMax = 180
            weapon = Mace()
        case .Dwarf:
            lifeMax = 80
            weapon = Axe()
        }
        
        life = lifeMax
    }
    
    func description() -> String {
        return "\(name) (\(type), \(weapon.power) ATK, \(life) PV)"
    }
    
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

enum CharacterType: Int {
    case Fighter
    case Mage
    case Colossus
    case Dwarf
    
    static var count: Int {
        var max = 0
        while let _ = CharacterType(rawValue: max) { max += 1 }
        return max
    }
}
