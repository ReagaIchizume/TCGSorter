//
//  MTGCardListItem.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import SwiftUI
import MTGSDKSwift

struct MTGCardListItem: View {
  
  let card: Card

  var cardColor: UIColor {
    if card.isLand {
      return .mtgLand
    }
    switch card.mtgColor {
      case .white:
        return .mtgWhite
      case .blue:
        return .mtgBlue
      case .black:
        return .mtgBlack
      case .red:
        return .mtgRed
      case .green:
        return .mtgGreen
      case .multi:
        return .mtgGold
      case .none:
        return .mtgVoid
    }
  }

  var textColor: UIColor {
    switch card.mtgColor {
      case .black, .none:
        return .white
      default:
        return .black
    }
  }
  
  var body: some View {
    HStack {
      VStack {
        Text(card.name ?? "").foregroundColor(Color(textColor))
        Text(card.type ?? "").foregroundColor(Color(textColor))
      }
      Text(card.manaCost ?? "").foregroundColor(Color(textColor))
    }.background(Color(cardColor))
  }
}

struct MTGCardListItem_Previews: PreviewProvider {
  static var testData: [Card] {
    var cards: [Card] = []

    var card1 = Card()
    card1.name = "Test White"
    card1.type = "Creature - Human Soldier"
    card1.manaCost = "1W"
    cards.append(card1)

    var card2 = Card()
    card2.name = "Test Blue"
    card2.type = "Sorcery"
    card2.manaCost = "3UU"
    cards.append(card2)

    var card3 = Card()
    card3.name = "Test Black"
    card3.type = "Instant"
    card3.manaCost = "B"
    cards.append(card3)

    var card4 = Card()
    card4.name = "Test Red"
    card4.type = "Planeswalker - Test"
    card4.manaCost = "6R"
    cards.append(card4)

    var card5 = Card()
    card5.name = "Test Green"
    card5.type = "Creature - Behemoth"
    card5.manaCost = "8GG"
    cards.append(card5)

    var card6 = Card()
    card6.name = "Test Void"
    card6.type = "Artifact - Equipment"
    card6.manaCost = "7"
    cards.append(card6)

    var card7 = Card()
    card7.name = "Test Multicolored"
    card7.type = "Enchantment"
    card7.manaCost = "WUBRG"
    cards.append(card7)

    var card8 = Card()
    card8.name = "Test Land"
    card8.type = "Basic Land - Mountain"
    card8.manaCost = ""
    cards.append(card8)

    return cards
  }

  static var previews: some View {
    List(testData) { card in
      MTGCardListItem(card: card)
    }
  }
}
