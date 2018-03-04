//
//  Game.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

class Game {
    var teams: [Team] = []
    var gameOver = false
    var winner: Team?
    var randomBonusNumber: UInt32
    var randomLimit: UInt32 = 10
    
    static let numberOfPlayers = 2
    static let numberOfCharactersByTeam = 3
    
    init() {
        print(" -- WELCOME TO BATTLE SWIFT -- ")
        randomBonusNumber = arc4random_uniform(randomLimit)
    }
    
    // Transform String number from readLine to Int
    func input() -> Int {
        guard let response = readLine(), let number = Int(response) else {
            return 0
        }
        return number
    }
    
    func randomInt(max: Int, min: Int = 0) -> Int {
        return Int(arc4random_uniform(UInt32(max))) + min
    }
    
    func unavailableChoice() -> String {
        return "Please choose an available choice"
    }
    
    func setUpTeams() {
        for i in 1...Game.numberOfPlayers {
            // Create a team of characters for each player
            let newPlayer = createTeam(index: i)
            // Add the new player and his team to our list of players
            self.teams.append(newPlayer)
        }
        
        print("\n\n*** GET READY FOR BATTLE ***")
        
        // Recap each teams
        for i in 0..<teams.count{
            let team = teams[i]
            print("\n\(team.playerName)")
            print("\(team.status())")
            if (i == 0) {
                print("\n......VS......")
            }
        }
        
        print("\n!!!!!! FIGHT !!!!!!\n")
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
        for i in 1...Game.numberOfCharactersByTeam {
            print("\n\(playerName) - choose the character \(i) of your team:")
            let newCharacter = createCharacter()
            charactersOfTheTeam.append(newCharacter)
        }
        
        return Team(playerName: playerName, characters: charactersOfTheTeam)
    }
    
    func createCharacter() -> Character {
        var availableChoice = false
        var typeOfTheCharacter =  CharacterType.Fighter
        var nameOfTheCharacter = ""
        
        repeat {
            // Show all types of character available
            for i in 0...CharacterType.count{
                if let type = CharacterType(rawValue: i) {
                    print(String(type.rawValue + 1) + ". \(type)")
                }
            }
            
            // Player choose the type of character he wants
            let typeChosen = input()
            
            // Check if the player choose an available option
            if (typeChosen == 0 || typeChosen > CharacterType.count) {
                print(unavailableChoice())
            } else {
                availableChoice = true
                typeOfTheCharacter = CharacterType(rawValue: typeChosen - 1)!
            }
        } while (!availableChoice)
        
        repeat {
            // Player choose a name for his character
            print("\nGive a name to this character")
            if let name = readLine() {
                nameOfTheCharacter = name
            }
        } while (nameOfTheCharacter.isEmpty)
        
        return Character(name: nameOfTheCharacter, type: typeOfTheCharacter)
    }
    
    func searchForBonus(character: Character) {
        let randomNumber = arc4random_uniform(randomLimit)
        
        if randomBonusNumber != randomNumber {
            print("\n\(randomNumber) != \(randomBonusNumber)")
        } else {
            let minLevel = 1
            var randomLevel: Int
            var newWeapon: Weapon
            var newWeaponType: String
            
            switch character.type {
            case .Colossus:
                randomLevel = randomInt(max: MaceLevel.count, min: minLevel)
                guard let newWeaponLevel = MaceLevel(rawValue: randomLevel) else {
                    return
                }
                newWeaponType = "\(newWeaponLevel)"
                newWeapon = Mace(level: randomLevel)
            case .Dwarf:
                randomLevel = randomInt(max: AxeLevel.count, min: minLevel)
                guard let newWeaponLevel = AxeLevel(rawValue: randomLevel) else {
                    return
                }
                newWeaponType = "\(newWeaponLevel)"
                newWeapon = Axe(level: randomLevel)
            case .Fighter:
                randomLevel = randomInt(max: SwordLevel.count, min: minLevel)
                guard let newWeaponLevel = SwordLevel(rawValue: randomLevel) else {
                    return
                }
                newWeaponType = "\(newWeaponLevel)"
                newWeapon = Sword(level: randomLevel)
            case .Mage:
                randomLevel = randomInt(max: RingLevel.count, min: minLevel)
                guard let newWeaponLevel = RingLevel(rawValue: randomLevel) else {
                    return
                }
                newWeaponType = "\(newWeaponLevel)"
                newWeapon = Ring(level: randomLevel)
            }
            
            character.weapon = newWeapon
            character.weaponUpdated = true
            print("A treasure chest appears in front of \(character.name), he opens it and ...")
            print("He found the \(newWeaponType) \(newWeapon.className)")
            print(character.description())
        }
    }
    
    func runBattle() {
        repeat{
            let characterPlaying = chooseCharacter(fromTeam: teams[0])
            if characterPlaying.weaponUpdated == false {
                searchForBonus(character: characterPlaying)
            }
            let characterTargeted = chooseTarget(depending: characterPlaying)
            
            // character does his action
            if (characterPlaying.weapon.className == "Ring") {
                characterTargeted.getHealed(by: characterPlaying)
            } else {
                characterTargeted.receiveDamage(from: characterPlaying)
                if characterTargeted.isDead {
                    teams[1].bringDeadToCemetery()
                    if teams[1].characters.count == 1 && teams[1].characters[0].type == .Mage {
                        giveAttackWeaponToMage(mage: teams[1].characters[0])
                    }
                }
            }
            
            if teams[1].characters.count == 0 {
                gameOver = true
                winner = teams[0]
            } else {
                teams.reverse()
            }
            
            print("\n****************************************")
            
        } while (!gameOver)
    }
    
    func chooseCharacter(fromTeam team: Team) -> Character {
        print("\n\n\(team.playerName) - Choose a character:")
        print(team.status())
        
        var availableCharacter = false
        var playerChoice = 0
        
        repeat {
            let choice = input()
            if (choice == 0 || choice > team.characters.count) {
                print(unavailableChoice())
            }
            else {
                availableCharacter = true
                playerChoice = (choice - 1)
            }
        } while (!availableCharacter)
        
        return team.characters[playerChoice]
    }
    
    func chooseTarget(depending character: Character) -> Character {
        var team: Team
        var contextMessage: String
        
        if character.weapon.className == "Ring" {
            team = teams[0]
            contextMessage = "\nChoose a team mate to cure:"
        }
        else {
            team = teams[1]
            contextMessage = "\nChoose an enemy to attack:"
        }
        
        var playerChoice: Int
        
        repeat {
            print(contextMessage)
            print(team.status())
            playerChoice = input()
        } while (playerChoice == 0 || playerChoice > team.characters.count)
        
        return team.characters[playerChoice - 1]
    }
    
    func giveAttackWeaponToMage(mage: Character) {
        let randomNumber =  randomInt(max: teams[1].cemetery.count)
        let randomPartner = teams[1].cemetery[randomNumber]
        let newWeapon = randomPartner.weapon
        
        mage.weapon = newWeapon
        mage.weaponUpdated = true
        print("\nBut \(mage.name) doesn't intend to surrender")
        print("He grabs the \(randomPartner.name)'s weapon")
    }
    
    func congratsWinner() {
        guard let winner = winner else {
            print("Error: game is over but we don't know the winner")
            return
        }
        print("\n👊 \(winner.playerName) WINS 👊\n")
    }
}
