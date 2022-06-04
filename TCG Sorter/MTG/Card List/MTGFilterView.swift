//
//  MTGFilterView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import SwiftUI
import MTGSDKSwift

struct MTGFilterView: View {

  // Textfield values
  @State var filteredName: String = ""
  @State var filteredCMC: String = ""
  @State var filteredColors: String = ""
  @State var filteredTypes: String = ""
  @State var filteredSubTypes: String = ""
  @State var filteredText: String = ""
  @State var filteredRarity: String = ""
  @State var filteredSet: String = ""
  @State var filteredPower: String = ""
  @State var filteredToughness: String = ""

  @State private var expanded: Bool = false

  var filterTypeDictionary: [CardSearchParameter.CardQueryParameterType: String] = [
    .name: "Name",
    .cmc: "Mana Value",
    .colors: "Colors",
    .supertypes: "Type",
    .subtypes: "Sub-Types",
    .rarity: "Rarity",
    .text: "Card Text",
    .set: "Set",
    .power: "Power",
    .toughness: "Toughness"
  ]

  /// Values being passed to query
  var filterStrings: [CardSearchParameter.CardQueryParameterType: String] {
    [.name: filteredName,
     .cmc: filteredCMC,
     .colors: filteredColors,
     .supertypes: filteredTypes,
     .subtypes: filteredSubTypes,
     .text: filteredText,
     .rarity: filteredRarity,
     .set: filteredSet,
     .power: filteredPower,
     .toughness: filteredToughness]
  }

  /// Actual objects used by the query
  var activeFilters: [CardSearchParameter] {
    var nonNilFilters: [CardSearchParameter] = []
    for (key, value) in filterStrings {
      if !value.isEmpty {
        nonNilFilters.append(CardSearchParameter(parameterType: key, value: value))
      }
    }
    return nonNilFilters
  }

  var body: some View {
    VStack {
      HStack {
        Spacer()
        TextField(filterTypeDictionary[.name] ?? "", text: $filteredName)
          .textFieldStyle(.roundedBorder)
        Spacer()
      }
      VStack {
        HStack {
          Spacer()
          TextField(filterTypeDictionary[.cmc] ?? "", text: $filteredCMC).textFieldStyle(.roundedBorder)
          // TODO: Colors
          Spacer()
        }
        HStack {
          Spacer()
          TextField(filterTypeDictionary[.supertypes] ?? "", text: $filteredTypes).textFieldStyle(.roundedBorder)
          TextField(filterTypeDictionary[.subtypes] ?? "", text: $filteredSubTypes).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField(filterTypeDictionary[.text] ?? "", text: $filteredText).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField(filterTypeDictionary[.rarity] ?? "", text: $filteredRarity).textFieldStyle(.roundedBorder)
          TextField(filterTypeDictionary[.set] ?? "", text: $filteredSet).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField(filterTypeDictionary[.power] ?? "", text: $filteredPower).textFieldStyle(.roundedBorder)
          TextField(filterTypeDictionary[.toughness] ?? "", text: $filteredToughness).textFieldStyle(.roundedBorder)
          Spacer()
        }
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: expanded ? .none : 0)
      .clipped()
      .animation(.linear)
      .transition(.slide)
      Button(action: { self.expanded.toggle() }, label: {
        Text(self.expanded ? "Collapse" : "Expand")
      })
    }
  }
}

struct MTGFilterView_Previews: PreviewProvider {
  static var previews: some View {
    MTGFilterView()
  }
}
