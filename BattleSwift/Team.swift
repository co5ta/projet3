//
//  Team.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// A Team object represent a player and the group of characters he chose to do the battle
class Team {
    /// The name of the player
    var playerName: String
    
    /// An array containing the Characters of the Team that will fight
    var characters: [Character]
    
    /// An array containing the Characters of the Team dead during the fight
    var cemetery: [Character] = []
    
    /// A Boolean indicating if there is still a living Character in the Team
    var isDefeated: Bool {
        return characters.count == 0 ? true : false
    }
    
    /// Boolean wich return true if the last character remaining in the Team is a Mage
    var lastCharacterIsMage: Bool {
        var result = false
        if (characters.count == 1 && characters[0].type == .Mage){
            result = true
        }
        return result
    }
    
    /// Initialize a Team with a player name and a list of Characters
    init (playerName: String, characters: [Character]) {
        self.playerName = playerName
        self.characters = characters
    }
    
    /// Return a complete list of characters from the team with their description
    func status() -> String {
        let allCharacters = characters + cemetery
        var text = "------"
        
        for i in 0..<allCharacters.count {
            if allCharacters[i].isDead{
                text += "\nDEAD -"
            } else {
                text += "\n\(i + 1)."
            }
            text += " \(allCharacters[i].description())"
        }
        text += "\n------"
        
        return text
    }
    
    /// Switch dead characters from the characters array to the cemetery array
    func bringDeadToCemetery() {
        for i in 0..<characters.count {
            if characters[i].isDead {
                let dead  = characters.remove(at: i)
                cemetery.append(dead)
                break
            }
        }
    }
}
