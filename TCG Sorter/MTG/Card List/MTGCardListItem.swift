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
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(card.name ?? "").foregroundColor(Color(.mtgTextColor))
        Text(card.type ?? "").foregroundColor(Color( .mtgTextColor))
      }
      Spacer()
      Text(card.manaCost ?? "").foregroundColor(Color(.mtgTextColor))
    }
    .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
  }
}

struct MTGCardListItem_Previews: PreviewProvider {
  static var testData: [Card] {
    return [
      Card(name: "Test White", type: "Creature - Human Soldier", manaCost: "1W", colors: ["white"]),
      Card(name: "Test Blue", type: "Sorcery", manaCost: "3UU", colors: ["blue"]),
      Card(name: "Test Black", type: "Instant", manaCost: "B", colors: ["black"]),
      Card(name: "Test Red", type: "Planeswalker - Test", manaCost: "6R", colors: ["red"]),
      Card(name: "Test Green", type: "Creature - Behemoth", manaCost: "8GG", colors: ["green"]),
      Card(name: "Test Void", type: "Artifact - Equipment", manaCost: "7"),
      Card(name: "Test Multicolored", type: "Enchantment", manaCost: "WUBRG", colors: ["white", "blue", "black", "red", "green"]),
      Card(name: "Test Land", type: "Basic Land - Mountain", manaCost: "")
    ]
  }

  static var previews: some View {
    List(testData) { card in
      MTGCardListItem(card: card)
    }
  }
}
