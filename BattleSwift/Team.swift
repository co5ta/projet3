//
//  Team.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

class Team {
    var playerName: String
    var characters: [Character]
    var cemetery: [Character] = []
    var isDefeated: Bool {
        return characters.count == 0 ? true : false
    }
    
    init (playerName: String, characters: [Character]) {
        self.playerName = playerName
        self.characters = characters
    }
    
    // Return complete list of characters from the team with their description
    func status() -> String {
        var text = "------"
        
        let allCharacters = characters + cemetery
        
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
