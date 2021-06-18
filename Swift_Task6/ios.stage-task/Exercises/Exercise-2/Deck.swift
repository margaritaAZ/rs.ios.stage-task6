import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {
    
    //MARK: - Properties
    
    var cards = [Card]()
    var type: DeckType
    var trump: Suit?
    
    var total:Int {
        return type.rawValue
    }
}

extension Deck {
    
    init(with type: DeckType) {
        self.type = type
        switch type {
        case .deck36:
            self.cards = createDeck(suits: [.clubs,.diamonds,.hearts,.spades],
                                    values: [.ace,.eight,.jack,.king,.nine,.queen,.seven,.six,.ten])
        }
    }
    
    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var deckCards = [Card]()
        for value in values.sorted(by: {$0.rawValue < $1.rawValue}) {
            for suit in suits.sorted(by: {$0.rawValue < $1.rawValue}) {
                deckCards.append(Card(suit: suit, value: value))
            }
        }
        return deckCards
    }
    
    public mutating func shuffle() {
        guard cards.count > 0 else {
            return
        }
        for i in 0...cards.count - 1 {
            let r = Int.random(in: 0...cards.count-1)
            let tmp = cards[r]
            cards[r] = cards[i]
            cards[i] = tmp
        }
    }
    
    public mutating func defineTrump() {
        guard let trump = cards.first?.suit else {
            return
        }
        self.trump = trump
        setTrumpCards(for: trump)
    }
    
    public mutating func initialCardsDealForPlayers(players: [Player]) {
        guard cards.count > 0 else {
            return
        }
        for player in players {
            var playerCards = 0
            while playerCards != 6 {
                if let card = cards.first {
                    if player.hand == nil {
                        player.hand = [card]
                    }
                    player.hand?.append(card)
                    cards.remove(at: 0)
                    playerCards += 1
                }
            }
        }
    }
    
    public mutating func setTrumpCards(for suit:Suit) {
        for i in 0...cards.count-1 {
            if cards[i].suit == suit {
                cards[i].isTrump = true
            }
        }
    }
}

