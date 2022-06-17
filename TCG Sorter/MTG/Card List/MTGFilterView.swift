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
}

struct MTGFilterView: View {

  @State private var expanded: Bool = false

  @ObservedObject var viewModel: MTGFilterViewModel

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
    [.name: viewModel.filteredName,
     .cmc: viewModel.filteredCMC,
     .colors: viewModel.filteredColors,
     .supertypes: viewModel.filteredTypes,
     .subtypes: viewModel.filteredSubTypes,
     .text: viewModel.filteredText,
     .rarity: viewModel.filteredRarity,
     .set: viewModel.filteredSet,
     .power: viewModel.filteredPower,
     .toughness: viewModel.filteredToughness]
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
        TextField(filterTypeDictionary[.name] ?? "", text: $viewModel.filteredName)
          .textFieldStyle(.roundedBorder)
        Spacer()
      }
      VStack {
        HStack {
          Spacer()
          TextField(filterTypeDictionary[.cmc] ?? "", text: $viewModel.filteredCMC).textFieldStyle(.roundedBorder)
          // TODO: Colors
          Spacer()
        }
        HStack {
          Spacer()
          TextField(filterTypeDictionary[.supertypes] ?? "", text: $viewModel.filteredTypes).textFieldStyle(.roundedBorder)
          TextField(filterTypeDictionary[.subtypes] ?? "", text: $viewModel.filteredSubTypes).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField(filterTypeDictionary[.text] ?? "", text: $viewModel.filteredText).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField(filterTypeDictionary[.rarity] ?? "", text: $viewModel.filteredRarity).textFieldStyle(.roundedBorder)
          TextField(filterTypeDictionary[.set] ?? "", text: $viewModel.filteredSet).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField(filterTypeDictionary[.power] ?? "", text: $viewModel.filteredPower).textFieldStyle(.roundedBorder)
          TextField(filterTypeDictionary[.toughness] ?? "", text: $viewModel.filteredToughness).textFieldStyle(.roundedBorder)
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
    MTGFilterView(viewModel: MTGFilterViewModel())
  }
}
