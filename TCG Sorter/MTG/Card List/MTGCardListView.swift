//
//  MTGCardListView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import SwiftUI
import MTGSDKSwift

/// This list is for pre-existing card lists such as a "deck" or a box.
/// A very similar list view will be used for searching. This is just for local
struct MTGCardListView: View {
  
  init(manager: MTGManager) {
    self.cardManager = manager
  }
  
  var cardManager: MTGManager
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
      switch CardSearchParameter.CardQueryParameterType(rawValue: filterType.name) {
        case .name:
          totalList = totalList.filter { $0.name?.contains(filterType.value) ?? false }
        case .cmc:
          // TODO: Support ranges, start with equal only
          guard let filteredCMC = Int(filterType.value) else { break }
          totalList = totalList.filter { $0.cmc == filteredCMC }
        case .colors:
          // TODO: Support subsets and exact matches, start with exact match for now
          let colors = filterType.value.components(separatedBy: ",").sorted()
          guard !colors.isEmpty else { break }
          totalList = totalList.filter { $0.colors?.sorted() == colors }
        case .supertypes:
          // TODO: Should we allow partial matches per word?
          let searchTypes = Set<String>(filterType.value.components(separatedBy: " "))
          totalList = totalList.filter { searchTypes.isSubset(of: $0.supertypes ?? []) }
        case .subtypes:
          // TODO: Should we allow partial matches per word?
          let searchTypes = Set<String>(filterType.value.components(separatedBy: " "))
          totalList = totalList.filter { searchTypes.isSubset(of: $0.subtypes ?? []) }
        case .rarity:
          totalList = totalList.filter { $0.rarity == filterType.value }
        case .text:
          // TODO: More general search. Now it's just a substring
          totalList = totalList.filter { $0.text?.contains(filterType.value) ?? false }
        case .set:
          totalList = totalList.filter { $0.set == filterType.value }
        case .power:
          totalList = totalList.filter { $0.power == filterType.value }
        case .toughness:
          totalList = totalList.filter { $0.toughness == filterType.value }
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

class PreviewManager: MTGManager {
  var page = 1
  
  func fetchBy(search activeFilters: [CardSearchParameter], completion: @escaping Magic.CardCompletion) {
    return
  }
  
  func fetchImage(for card: Card, completion: @escaping Magic.CardImageCompletion) {
    return
  }
  

  func fetchAll(completion: @escaping Magic.CardCompletion) {
    let cards = MTGCardListItem_Previews.testData
    completion(.success(cards))
  }

}

struct MTGCardListView_Previews: PreviewProvider {
  static func setUpPreview() -> some View {
    let previewManager = PreviewManager()
    let list = MTGCardListView(manager: previewManager)
    previewManager.fetchAll { result in
      switch result {
        case .success(let cards):
          list.cardList = cards
        case .error:
          break
      }
    }
    return list
  }
    static var previews: some View {
        setUpPreview()
    }
}
