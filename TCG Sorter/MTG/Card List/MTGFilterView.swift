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
  @Published var filteredName: String = "" {
    didSet {
      typeAction(activeFilters)
    }
  }
  @Published var filteredCMC: String = "" {
    didSet {
      typeAction(activeFilters)
    }
  }
  var filteredColors: String = "" {
    didSet {
      typeAction(activeFilters)
    }
  }
  @Published var filteredTypes: String = "" {
    didSet {
      typeAction(activeFilters)
    }
  }
  @Published var filteredSubTypes: String = "" {
    didSet {
      typeAction(activeFilters)
    }
  }
  @Published var filteredText: String = "" {
    didSet {
      typeAction(activeFilters)
    }
  }
  @Published var filteredRarity: String = "" {
    didSet {
      typeAction(activeFilters)
    }
  }
  @Published var filteredSet: String = "" {
    didSet {
      typeAction(activeFilters)
    }
  }
  @Published var filteredPower: String = "" {
    didSet {
      typeAction(activeFilters)
    }
  }
  @Published var filteredToughness: String = "" {
    didSet {
      typeAction(activeFilters)
    }
  }

  // MARK: Colors
  @Published fileprivate var whiteChecked: Bool = false
  @Published fileprivate var blueChecked: Bool = false
  @Published fileprivate var blackChecked: Bool = false
  @Published fileprivate var redChecked: Bool = false
  @Published fileprivate var greenChecked: Bool = false
  @Published fileprivate var colorlessChecked: Bool = false

  var filterTypeDictionary: [CardSearchParameter.CardQueryParameterType: String] = [
      .name: "Name",
      .cmc: "Mana Value",
      .colors: "Colors",
      .type: "Type",
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
      .type: filteredTypes,
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

  var typeAction: ([CardSearchParameter]) -> Void

  init(typeAction: @escaping ([CardSearchParameter]) -> Void = { _ in }) {
    self.typeAction = typeAction
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
        Text(viewModel.filterTypeDictionary[.colors] ?? "")
        HStack {
          Spacer()
          Toggle("W", isOn: $viewModel.whiteChecked).toggleStyle(CheckBoxToggleStyle())
            .onChange(of: viewModel.whiteChecked, perform: { whiteChecked in
              if viewModel.colorlessChecked {
                viewModel.colorlessChecked = false
              }
              if whiteChecked {
                viewModel.filteredColors += viewModel.filteredColors.isEmpty ? "white" : ",white"
              } else {
                viewModel.filteredColors = viewModel.filteredColors.replacingOccurrences(of: ",white", with: "")
                viewModel.filteredColors = viewModel.filteredColors.replacingOccurrences(of: "white", with: "")
              }
            })
          Toggle("U", isOn: $viewModel.blueChecked).toggleStyle(CheckBoxToggleStyle())
            .onChange(of: viewModel.blueChecked, perform: { blueChecked in
              if viewModel.colorlessChecked {
                viewModel.colorlessChecked = false
              }
              if blueChecked {
                viewModel.filteredColors += viewModel.filteredColors.isEmpty ? "blue" : ",blue"
              } else {
                viewModel.filteredColors = viewModel.filteredColors.replacingOccurrences(of: ",blue", with: "")
                viewModel.filteredColors = viewModel.filteredColors.replacingOccurrences(of: "blue", with: "")
              }
            })
          Toggle("B", isOn: $viewModel.blackChecked).toggleStyle(CheckBoxToggleStyle())
            .onChange(of: viewModel.blackChecked, perform: { blackChecked in
              if viewModel.colorlessChecked {
                viewModel.colorlessChecked = false
              }
              if blackChecked {
                viewModel.filteredColors += viewModel.filteredColors.isEmpty ? "black" : ",black"
              } else {
                viewModel.filteredColors = viewModel.filteredColors.replacingOccurrences(of: ",black", with: "")
                viewModel.filteredColors = viewModel.filteredColors.replacingOccurrences(of: "black", with: "")
              }
            })
          Toggle("R", isOn: $viewModel.redChecked).toggleStyle(CheckBoxToggleStyle())
            .onChange(of: viewModel.redChecked, perform: { redChecked in
              if viewModel.colorlessChecked {
                viewModel.colorlessChecked = false
              }
              if redChecked {
                viewModel.filteredColors += viewModel.filteredColors.isEmpty ? "red" : ",red"
              } else {
                viewModel.filteredColors = viewModel.filteredColors.replacingOccurrences(of: ",red", with: "")
                viewModel.filteredColors = viewModel.filteredColors.replacingOccurrences(of: "red", with: "")
              }
            })
          Toggle("G", isOn: $viewModel.greenChecked).toggleStyle(CheckBoxToggleStyle())
            .onChange(of: viewModel.greenChecked, perform: { greenChecked in
              if viewModel.colorlessChecked {
                viewModel.colorlessChecked = false
              }
              if greenChecked {
                viewModel.filteredColors += viewModel.filteredColors.isEmpty ? "green" : ",green"
              } else {
                viewModel.filteredColors = viewModel.filteredColors.replacingOccurrences(of: ",green", with: "")
                viewModel.filteredColors = viewModel.filteredColors.replacingOccurrences(of: "green", with: "")
              }
            })
          Toggle("Void", isOn: $viewModel.colorlessChecked).toggleStyle(CheckBoxToggleStyle())
            .onChange(of: viewModel.colorlessChecked, perform: { colorlessChecked in
              if colorlessChecked {
                viewModel.whiteChecked = false
                viewModel.blueChecked = false
                viewModel.blackChecked = false
                viewModel.redChecked = false
                viewModel.greenChecked = false
                viewModel.filteredColors = "colorless"
              } else {
                viewModel.filteredColors = ""
              }
            })
          Spacer()
        }
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
          TextField(viewModel.filterTypeDictionary[.type] ?? "", text: $viewModel.filteredTypes).textFieldStyle(.roundedBorder)
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
