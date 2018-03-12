//
//  Weapon.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// Minimum strength of the Sword
let minValueSwordPower = 10

/// Minimum strength of the Ring
let minValueRingPower = 8

/// Minimum strength of the Mace
let minValueMacePower = 6

/// Minimum strength of the Axe
let minValueAxePower = 14

/// Minimum strength of the Knife
let minValueKnifePower = 8


/// Weapon protocol
protocol Weapon {
    /// The power of the weapon represents number of life points it will add or remove to the enemy
    var power: Int { get }
    /// Return the name of the class
    var typeName: String { get }
    /// Optional wich return the bas state that can give a weapon to a character
    var canGiveStatus: WeaponEffect? { get }
    /// Return true if 2 rand numbers are equals
    func randomSuccess(limit: UInt32) -> Bool
    /// Do the specific action possible with an a weapon
    func specialAction(_ characterPlaying: Character, _ characterTargeted: Character) -> ()
}

/// Weapon extension
extension Weapon {
    /// Return the name of the class
    var typeName: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    /// Return true if 2 rand numbers are equals
    func randomSuccess(limit: UInt32) -> Bool {
        let randomLimit: UInt32 = limit
        let rand1 = arc4random_uniform(randomLimit)
        let rand2 = arc4random_uniform(randomLimit)
        print("\(rand1) \(rand2)") // test
        return rand1 == rand2 ? true : false
    }
    
    /// Use a special action on the character targeted
    func specialAction(_ characterPlaying: Character, _ characterTargeted: Character) -> () {
        guard let newStatus = self.canGiveStatus  else {
            print("But it has no effect")
            return
        }
        
        let targetName = characterPlaying.name == characterTargeted.name ? "himself" : characterTargeted.name
        print("\(characterPlaying.name) tries to \(newStatus.linkedAction) \(targetName)")
        
        guard (characterTargeted.status[newStatus] == nil) else {
            print("\(characterTargeted.name) is already \(newStatus)")
            return
        }
        
        guard randomSuccess(limit: 2) else {
            print("But \(characterPlaying.name) failed")
            return
        }
        
        characterTargeted.status[newStatus] = newStatus.duration
        print("\(characterTargeted.name) is \(newStatus)")
    }
}

/// Enum listing possible bad states that can be given to enemy
enum WeaponEffect {
    case Stunned, Poisonned, Blinded
    
    /// Return the name of the Action linked to the bad state
    var linkedAction: String {
        switch self {
        case .Stunned:
            return "Stun"
        case .Poisonned:
            return "Poison"
        case .Blinded:
            return "Blind"
        }
    }
    
    /// Return how long is the bad state
    var duration: Int {
        switch self {
        case .Stunned:
            return 1
        case .Blinded:
            return 2
        default:
            return 0
        }
    }
}

/// Help to manage weapon assignement
struct WeaponFactory {
    /// Return a weapon depending on the type of Character to equip
    static func giveWeapon(toCharacterOfType type: CharacterType, level: Int = 0) -> Weapon {
        switch type {
        case .Fighter:
            return Sword(rawValue: level)!
        case .Mage:
            return Ring(rawValue: level)!
        case .Colossus:
            return Mace(rawValue: level)!
        case .Dwarf:
            return Axe(rawValue: level)!
        case .Assassin:
            return Knife(rawValue: level)!
        }
    }
}

/// Sword is the weapon of the Fighter
enum Sword: Int, Weapon, CaseCountable {
    
    /// Type of Sword available
    case Heavy, Musketeer, Justice, Damoclès, Excalibur
    
    /// Return the power of the weapon depending on the case
    var power: Int {
        switch self {
        case .Heavy:
            return minValueSwordPower    // 10 ATK
        case .Musketeer:
            return minValueSwordPower  + 3
        case .Justice:
            return minValueSwordPower  + 6
        case .Damoclès:
            return minValueSwordPower  + 8
        case .Excalibur:
            return minValueSwordPower  + 10
        }
    }

    /// Return an optional containing or not the name of the special action wich can do the weapon
    var canGiveStatus: WeaponEffect? {
        return nil
    }
}

/// Ring is the weapon of the Mage
enum Ring: Int, Weapon, CaseCountable {
    /// Type of Ring available
    case Druid, Archmage, Merlin
    
    /// Return the power of the weapon depending on the case
    var power: Int {
        switch self {
        case .Druid:
            return minValueRingPower     // 8 ATK
        case .Archmage:
            return minValueRingPower + 4
        case .Merlin:
            return minValueRingPower + 7
        }
    }
    
    /// Return an optional containing or not the name of the special action wich can do the weapon
    var canGiveStatus: WeaponEffect? {
        return nil
    }
}

/// Mace is the weapon of the Colossus
enum Mace: Int, Weapon, CaseCountable {
    /// Type of Mace available
    case Aries, Taurus, Gorilla, Rhino
    
    /// Return the power of the weapon depending on the case
    var power: Int {
        switch self {
        case .Aries:
            return minValueMacePower     // 6 ATK
        case .Taurus:
            return minValueMacePower + 3
        case .Gorilla:
            return minValueMacePower + 5
        case .Rhino:
            return minValueMacePower + 8
        }
    }
    
    /// Return an optional containing or not the name of the special action wich can do the weapon
    var canGiveStatus: WeaponEffect? {
        return .Stunned
    }
}

/// Axe is the weapon of the Dwarf
enum Axe: Int, Weapon, CaseCountable {
    /// Type of Axe available
    case Scopper, Silver, Golden, Diamond
    
    /// Return the power of the weapon depending on the case
    var power: Int {
        switch self {
        case .Scopper:
            return minValueAxePower      // 14 ATK
        case .Silver:
            return minValueAxePower  + 2
        case .Golden:
            return minValueAxePower  + 4
        case .Diamond:
            return minValueAxePower  + 7
        }
    }
    
    /// Return an optional containing or not the name of the special action wich can do the weapon
    var canGiveStatus: WeaponEffect? {
        return .Blinded
    }
}

/// Knife is the weapon of the Assassin
enum Knife: Int, Weapon, CaseCountable {
    /// Type of Knife available
    case Venom, Toxin, Cyanide
    
    /// Return the power of the weapon depending on the case
    var power: Int {
        switch self {
        case .Venom:
            return minValueKnifePower         // 8 ATK
        case .Toxin:
            return minValueKnifePower + 3
        case .Cyanide:
            return minValueKnifePower + 6
        }
    }
    
    /// Return an optional containing or not the name of the special action wich can do the weapon
    var canGiveStatus: WeaponEffect? {
        return .Poisonned
    }
}
