//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {
    
    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        var playerWithMinimal: Player?
        var minimalTrumpCard: Card?
        
        for player in players {
            if let playerCards = player.hand {
                for card in playerCards where card.isTrump == true {
                    if card.value.rawValue < minimalTrumpCard?.value.rawValue ?? 10 {
                        playerWithMinimal = player
                        minimalTrumpCard = card
                    }
                }
            }
        }
        return playerWithMinimal
    }
}
