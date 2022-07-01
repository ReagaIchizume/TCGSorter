//
//  MTGFilterView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import SwiftUI
import MTGSDKSwift

class MTGFilterViewModel: ObservableObject {
  // Textfield values
  @Published var filteredName: String = ""
  @Published var filteredCMC: String = ""
  @Published var filteredColors: String = ""
  @Published var filteredTypes: String = ""
  @Published var filteredSubTypes: String = ""
  @Published var filteredText: String = ""
  @Published var filteredRarity: String = ""
  @Published var filteredSet: String = ""
  @Published var filteredPower: String = ""
  @Published var filteredToughness: String = ""

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
    [
      .name: filteredName,
     .cmc: filteredCMC,
     .colors: filteredColors,
     .supertypes: filteredTypes,
     .subtypes: filteredSubTypes,
     .text: filteredText,
     .rarity: filteredRarity,
     .set: filteredSet,
     .power: filteredPower,
     .toughness: filteredToughness
    ]
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
}

struct MTGFilterView: View {

  @State private var expanded: Bool = false

  @EnvironmentObject var viewModel: MTGFilterViewModel

  var body: some View {
    VStack {
      HStack {
        Spacer()
        TextField(viewModel.filterTypeDictionary[.name] ?? "", text: $viewModel.filteredName)
          .textFieldStyle(.roundedBorder)
        Spacer()
      }
      VStack {
        HStack {
          Spacer()
          TextField(viewModel.filterTypeDictionary[.cmc] ?? "", text: $viewModel.filteredCMC).textFieldStyle(.roundedBorder)
          // TODO: Colors
          Spacer()
        }
        HStack {
          Spacer()
          TextField(viewModel.filterTypeDictionary[.supertypes] ?? "", text: $viewModel.filteredTypes).textFieldStyle(.roundedBorder)
          TextField(viewModel.filterTypeDictionary[.subtypes] ?? "", text: $viewModel.filteredSubTypes).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField(viewModel.filterTypeDictionary[.text] ?? "", text: $viewModel.filteredText).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField(viewModel.filterTypeDictionary[.rarity] ?? "", text: $viewModel.filteredRarity).textFieldStyle(.roundedBorder)
          TextField(viewModel.filterTypeDictionary[.set] ?? "", text: $viewModel.filteredSet).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField(viewModel.filterTypeDictionary[.power] ?? "", text: $viewModel.filteredPower).textFieldStyle(.roundedBorder)
          TextField(viewModel.filterTypeDictionary[.toughness] ?? "", text: $viewModel.filteredToughness).textFieldStyle(.roundedBorder)
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
