//
//  MTGFilterView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import SwiftUI
import ScryfallKit

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

  /// Values being passed to query
  var cardFilters: [CardFieldFilter] {
    [
      .name(filteredName),
      .cmc(filteredCMC, .equal),
      .colors(filteredColors, ComparisonType.including),
      .type(filteredTypes),
      .fullOracleText(filteredText),
      .rarity(filteredRarity, .equal),
      .set(filteredSet),
      .power(filteredPower, .equal),
      .toughness(filteredToughness, .equal)
    ]
  }
  
  /// Actual objects used by the query
  var activeFilters: [CardFieldFilter] {
    var nonNilFilters: [CardFieldFilter] = []
    for filter in cardFilters {
      switch filter {
        case .name(let name) where !name.isEmpty:
          nonNilFilters.append(filter)
        case .cmc(let cmc, _) where !cmc.isEmpty:
          nonNilFilters.append(filter)
        case .colors(let colors, _) where !colors.isEmpty:
          nonNilFilters.append(filter)
        case .type(let type) where !type.isEmpty:
          nonNilFilters.append(filter)
        case .fullOracleText(let text) where !text.isEmpty:
          nonNilFilters.append(filter)
        case .rarity(let rarity, _) where !rarity.isEmpty:
          nonNilFilters.append(filter)
        case .set(let set) where !set.isEmpty:
          nonNilFilters.append(filter)
        case .power(let power, _) where !power.isEmpty:
          nonNilFilters.append(filter)
        case .toughness(let toughness, _) where !toughness.isEmpty:
          nonNilFilters.append(filter)
        default:
          break
      }
    }
    return nonNilFilters
  }

  var typeAction: ([CardFieldFilter]) -> Void

  init(typeAction: @escaping ([CardFieldFilter]) -> Void = { _ in }) {
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
        TextField("Name", text: $viewModel.filteredName)
          .textFieldStyle(.roundedBorder)
        Spacer()
      }
      VStack {
        Text("Colors")
        HStack {
          Spacer()
          Toggle(Card.Color.W.rawValue, isOn: $viewModel.whiteChecked).toggleStyle(CheckBoxToggleStyle())
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
          Toggle(Card.Color.U.rawValue, isOn: $viewModel.blueChecked).toggleStyle(CheckBoxToggleStyle())
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
          Toggle(Card.Color.B.rawValue, isOn: $viewModel.blackChecked).toggleStyle(CheckBoxToggleStyle())
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
          Toggle(Card.Color.R.rawValue, isOn: $viewModel.redChecked).toggleStyle(CheckBoxToggleStyle())
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
          Toggle(Card.Color.G.rawValue, isOn: $viewModel.greenChecked).toggleStyle(CheckBoxToggleStyle())
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
          Toggle(Card.Color.C.rawValue, isOn: $viewModel.colorlessChecked).toggleStyle(CheckBoxToggleStyle())
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
          TextField("Mana Value", text: $viewModel.filteredCMC).textFieldStyle(.roundedBorder)
          // TODO: Colors
          Spacer()
        }
        HStack {
          Spacer()
          TextField("Type", text: $viewModel.filteredTypes).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField("Rules Text", text: $viewModel.filteredText).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField("Rarity", text: $viewModel.filteredRarity).textFieldStyle(.roundedBorder)
          TextField("Set", text: $viewModel.filteredSet).textFieldStyle(.roundedBorder)
          Spacer()
        }
        HStack {
          Spacer()
          TextField("Power", text: $viewModel.filteredPower).textFieldStyle(.roundedBorder)
          TextField("Toughness", text: $viewModel.filteredToughness).textFieldStyle(.roundedBorder)
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
