//
//  Team.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

struct Team {
    var playerName: String
    var characters: [Character]
    
    static let numberOfCharactersByTeam = 3
    
    // Return complete list of characters from de team with their description
    func status() -> String {
        var text = "\n\(playerName)"
        text += "\n------"
        for i in 0..<characters.count {
            text += "\n\(characters[i].description())"
        }
        text += "\n------"
        
        return text
    }
}
