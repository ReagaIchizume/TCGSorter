//
//  MTGCardListView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import SwiftUI
import ScryfallKit

/// This list is for pre-existing card lists such as a "deck" or a box.
/// A very similar list view will be used for searching. This is just for local
struct MTGCardListView: View {
  
  @State var cardList: [Card] = MTGCardListItem_Previews.testData

  var filteredCardList: [Card] {
    cardList.filter {
      self.passesFilter(self.filterViewModel, $0)
    }
  }
  
  @StateObject var filterViewModel: MTGFilterViewModel = MTGFilterViewModel()

  private func passesFilter(_ filterViewModel: MTGFilterViewModel, _ card: Card) -> Bool {
    // Start from the whole list
    var totalList = cardList
    // Loop through filters the user has input
     for filterType in filterViewModel.activeFilters {
      switch filterType {
        case .name(let name):
          totalList = totalList.filter { $0.name.contains(name) }
        case .cmc(let cmc, let comparisonType):
          // TODO: Support ranges, start with equal only
          guard let filteredCMC = Double(cmc) else { break }
          totalList = totalList.filter {
            switch comparisonType {
              case .equal: return $0.cmc == filteredCMC
              case .greaterThanOrEqual: return $0.cmc >= filteredCMC
              case .greaterThan: return $0.cmc > filteredCMC
              case .lessThan: return $0.cmc < filteredCMC
              case .lessThanOrEqual: return $0.cmc <= filteredCMC
              case .notEqual: return $0.cmc != filteredCMC
              default:
                return false
            }
          }
        case .colors(let colors, _):
          // TODO: Support subsets and exact matches, start with exact match for now
          let colors = colors.components(separatedBy: ",").sorted().compactMap { Card.Color(rawValue: $0) }
          guard !colors.isEmpty else { break }
          totalList = totalList.filter {
            var passes = true
            for color in $0.colors ?? [] {
              if !colors.contains(color) { passes = false }
            }
            return passes
          }
        case .type(let type):
          // TODO: Should we allow partial matches per word?
          let searchTypes = Set<String>(type.replacingOccurrences(of: "-", with: "").components(separatedBy: " "))
          totalList = totalList.filter { searchTypes.isSubset(of: Set<String>($0.typeLine?.replacingOccurrences(of: "-", with: "").components(separatedBy: " ") ?? [])) }
        case .rarity(let rarity, _):
          totalList = totalList.filter { $0.rarity.rawValue == rarity }
        case .oracleText(let text):
          // TODO: More general search. Now it's just a substring
          totalList = totalList.filter { $0.oracleText?.contains(text) ?? false }
        case .set(let set):
          totalList = totalList.filter { $0.set == set }
        case .power(let power, _):
          totalList = totalList.filter { $0.power == power }
        case .toughness(let toughness, _):
          totalList = totalList.filter { $0.toughness == toughness }
        default:
          break
      }
    }
    return totalList.contains(card)
  }

  var body: some View {
    VStack {
      MTGFilterView()
      Spacer()
      if #available(iOS 15.0, *) {
        List(filteredCardList) {
            MTGCardListItem(card: $0)
              .listRowBackground(Color($0.cardColor))
              .listRowSeparator(.hidden)
        }
      } else {
        ScrollView {
          LazyVStack {
            ForEach(filteredCardList) {
              MTGCardListItem(card: $0)
                .background(Color($0.cardColor))
            }
            Spacer()
              .frame(width: 0, height: 0, alignment: .center)
              .onAppear() {
                // TODO: Set next page
              }
          }
        }
      }
      Spacer()
    }
    .environmentObject(filterViewModel)
  }
}

struct MTGCardListView_Previews: PreviewProvider {
  static func setUpPreview() -> some View {
    let list = MTGCardListView()
    list.cardList = MTGCardListItem_Previews.testData
    return list
  }
    static var previews: some View {
        setUpPreview()
    }
}
