//
//  Game.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

struct Game {
    var teams: [Team] = []
    var gameOver = false
    
    static let numberOfPlayers = 2
    
    // Transform String number from readLine to Int
    func input() -> Int {
        guard let response = readLine(), let number = Int(response) else {
            return 0
        }
        return number
    }
    
    init() {
        print(" -- WELCOME TO BATTLE SWIFT -- ")
    }
    
    mutating func teamsSetUp() {
        for i in 1...Game.numberOfPlayers {
            // Create a team of characters for each player
            let newPlayer = createTeam(index: i)
            // Add the new player and his team to our list of players
            self.teams.append(newPlayer)
        }
        
        print("\n*** GET READY FOR BATTLE ***")
        
        // Recap each teams
        for i in 0..<teams.count{
            print("\(teams[i].status())")
            if (i == 0) {
                print("\n......VS......")
            }
        }
        
        print("\n!!!!!! FIGHT !!!!!!")
    }
    
    func createTeam(index: Int) -> Team {
        var playerName = ""
        var charactersOfTheTeam: [Character] = []
        
        repeat {
            print("\nPlayer\(index) enter your name:")
            
            // Check if the player entered a name
            if let name = readLine() {
                playerName = name.uppercased()
            }
        } while playerName.isEmpty
        
        // Create each character of the team
        for i in 1...Team.numberOfCharactersByTeam {
            print("\n\(playerName) - choose the character \(i) of your team:")
            let newCharacter = createCharacter()
            charactersOfTheTeam.append(newCharacter)
        }
        
        return Team(playerName: playerName, characters: charactersOfTheTeam)
    }
    
    func createCharacter() -> Character {
        var availableChoice = false
        var typeOfTheCharacter = CharacterType.Fighter
        var nameOfTheCharacter = ""
        
        repeat {
            // Show all types of character available
            for i in 0...CharacterType.count{
                if let type = CharacterType(rawValue: i) {
                    print(String(type.rawValue) + ". \(type)")
                }
            }
            
            // Player choose the type of character he wants
            let typeChosen = input()
            
            // Check if the player choose an available option
            if (typeChosen == 0 || typeChosen > CharacterType.count) {
                print("Please choose an available option")
            } else {
                availableChoice = true
                typeOfTheCharacter = CharacterType(rawValue: typeChosen)!
            }
        } while (!availableChoice)
        
        repeat {
            // Player choose a name for his character
            print("Give a name to this character")
            if let name = readLine() {
                nameOfTheCharacter = name
            }
        } while (nameOfTheCharacter.isEmpty)
        
        return Character(name: nameOfTheCharacter, type: typeOfTheCharacter)
    }
    
}
