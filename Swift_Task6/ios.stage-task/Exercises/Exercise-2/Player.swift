//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?
    
    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        guard let playerCards = self.hand else {
            return false
        }
        for playerCard in playerCards {
            if playerCard.value == card.value {
                return true
            }
        }
        return false
    }
    
    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        for (firstCard, secondCard) in table {
            if checkIfCanTossWhenAttacking(card: firstCard) || checkIfCanTossWhenAttacking(card: secondCard) {
                return true
            }
        }
        return false
    }
}
