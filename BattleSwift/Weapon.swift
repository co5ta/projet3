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
}

/// Weapon extension
extension Weapon {
    /// Return the name of the class
    var typeName: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
}

/// Armory structure which help to manage weapon
struct Armory {
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
}
