//
//  main.swift
//  BattleSwift
//
//  Created by Co5ta on 22/02/2018.
//  Copyright © 2018 Co5ta. All rights reserved.
//

import Foundation

// Start a new game
var game = Game()

// Create players and their team
game.setUpTeams()

// Start the battle
game.runBattle()

// Game over - congrats to winner
game.congratsWinner()
