//
//  Game.swift
//  BattleSwift
//
//  Created by Co5ta on 24/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

/// An encapsulatation of the different stages of the game
class Game {
    /// Array containing each player and his Team, that will fight
    var teams: [Team] = []
    
    /// Boolean indicating end of the game
    var gameOver = false
    
    /// Give the Team wich wins the battle
    var winner: Team?
    
    /// A random number. If it is found during the battle, current Character get a better weapon
    var randomBonusNumber: UInt32
    
    /// The maximum limit for the randomBonusNumber
    var randomLimit: UInt32 = 10
    
    /// Number of players (Teams) in the game
    static let numberOfPlayers = 2
    
    /// Number of Characters in each Team
    static let numberOfCharactersByTeam = 3
    
    ///
    var playersNames: [String] = []
    
    ///
    var charactersNames: [String] = []
    
    /// Initialize a new Game
    init() {
        print(" -- WELCOME TO BATTLE SWIFT -- ")
        randomBonusNumber = arc4random_uniform(randomLimit)
    }
    
    /// Transform String number from readLine to Int
    func input() -> Int {
        guard let response = readLine(), let number = Int(response) else {
            return 0
        }
        return number
    }
    
    /// Return a random Int between parameters min and max
    func randomInt(max: Int, min: Int = 0) -> Int {
        return Int(arc4random_uniform(UInt32(max))) + min
    }
    
    /// Return an error message for the player when he makes an unavailable choice
    func unavailableChoice() -> String {
        return "Please choose an available choice"
    }
    
    /// Set up players, Teams, and Characters before the battle start
    func setUpTeams() {
        for i in 1...Game.numberOfPlayers {
            let newTeam = createTeam(index: i)
            self.teams.append(newTeam)
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
    
    /// Return a Team with characterics chosen by the player
    func createTeam(index: Int) -> Team {
        var playerName = ""
        var charactersOfTheTeam: [Character] = []
        var hasMage = false
        
        repeat {
            print("\nPlayer\(index) enter your name:")
            
            // Check if the player entered a unique name
            if let name = readLine()?.uppercased(), !playersNames.contains(name) {
                playerName = name
            } else {
                print("This name has already been taken")
            }
        } while (playerName.isEmpty)
        
        /// Add the name to the list of players names
        playersNames.append(playerName)
        
        // Create each character of the team
        for i in 1...Game.numberOfCharactersByTeam {
            print("\n\(playerName) - choose the character \(i) of your team:")
            
            let newCharacter = createCharacter(typeMageForbidden: hasMage)
            print("\(newCharacter.description()) joins your team")
            
            charactersOfTheTeam.append(newCharacter)
            hasMage = newCharacter.type == .Mage ? true : false
        }
        
        return Team(playerName: playerName, characters: charactersOfTheTeam)
    }
    
    /// Return a Character named and typed by player
    func createCharacter(typeMageForbidden: Bool) -> Character {
        var availableChoice = false
        var typeOfTheCharacter =  CharacterType.Fighter
        var nameOfTheCharacter = ""
        
        repeat {
            // Show all types of character available
            for i in 0...CharacterType.count{
                if let type = CharacterType(rawValue: i) {
                    if type == .Mage && typeMageForbidden {
                        continue
                    } else {
                        print(String(type.rawValue + 1) + ". \(type)")
                    }
                }
            }
            
            // Player choose the type of character he wants
            let typeChosen = input()
            
            // Check if the player choose an available option
            if (typeChosen == 0 || typeChosen > CharacterType.count ||
                (typeChosen == (CharacterType.Mage.rawValue + 1) && typeMageForbidden))
            {
                print(unavailableChoice())
            } else {
                availableChoice = true
                typeOfTheCharacter = CharacterType(rawValue: typeChosen - 1)!
            }
            
        } while (!availableChoice)
        
        repeat {
            // Player choose a name for his character
            print("\nGive a name to this character")
            if let name = readLine()?.uppercased(), !charactersNames.contains(name) {
                nameOfTheCharacter = name
            } else {
                print("This name has already been given to a character")
            }
        } while (nameOfTheCharacter.isEmpty)
        
        /// Add the name in the array listing all characters names in the game
        charactersNames.append(nameOfTheCharacter)
        
        return Character(name: nameOfTheCharacter, type: typeOfTheCharacter)
    }
    
    /// Perform the battle sequence
    func runBattle() {
        repeat{
            let characterPlaying = chooseCharacter(fromTeam: teams[0])
            if characterPlaying.weaponUpdated == false {
                searchForBonus(character: characterPlaying)
            }
            let characterTargeted = chooseTarget(depending: characterPlaying)
            
            // Character does his action
            if (characterPlaying.weapon is Ring) {
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
    
    /// Return the Character chosen by the player, who will do an action
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
    
    /// Return the Character chosen, with his weapon updated if the randomBonusNumber is found
    func searchForBonus(character: Character) {
        let randomNumber = arc4random_uniform(randomLimit)
        
        if randomBonusNumber == randomNumber {
            let minLevel = 1
            var randomLevel: Int
            var newWeapon: Weapon
            
            switch character.type {
            case .Colossus:
                randomLevel = randomInt(max: (Mace.count - 1), min: minLevel)
            case .Dwarf:
                randomLevel = randomInt(max: (Axe.count - 1), min: minLevel)
            case .Fighter:
                randomLevel = randomInt(max: (Sword.count - 1), min: minLevel)
            case .Mage:
                randomLevel = randomInt(max: (Ring.count - 1), min: minLevel)
            case .Assassin:
                randomLevel = randomInt(max: (Knife.count - 1), min: minLevel)
            }
            
            newWeapon = Armory.giveWeapon(toCharacterOfType: character.type, level: randomLevel)
            character.weapon = newWeapon
            character.weaponUpdated = true
            
            print("A treasure chest appears in front of \(character.name), he opens it and ...")
            print("He found the \(newWeapon) \(newWeapon.typeName)")
            print(character.description())
        }
    }
    
    /// Return the Character chosen by the player who will receive the effect of an action
    func chooseTarget(depending character: Character) -> Character {
        var team: Team
        var contextMessage: String
        
        if character.weapon is Ring {
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
    
    /// Give an attack weapon to the Mage if he is the last Character of the Team
    func giveAttackWeaponToMage(mage: Character) {
        let randomNumber =  randomInt(max: teams[1].cemetery.count)
        let randomPartner = teams[1].cemetery[randomNumber]
        let newWeapon = randomPartner.weapon
        
        mage.weapon = newWeapon
        mage.weaponUpdated = true
        print("\nBut \(mage.name) doesn't intend to surrender")
        print("He grabs the \(randomPartner.name)'s weapon")
    }
    
    /// End the Game with a congrats message to the winner
    func congratsWinner() {
        guard let winner = winner else {
            print("Error: game is over but we don't know the winner")
            return
        }
        print("\n👊 \(winner.playerName) WINS 👊\n")
    }
}
