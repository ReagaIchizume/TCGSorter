//
//  MTGCardSearchView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 7/15/22.
//

import SwiftUI
import ScryfallKit

class MTGSearchModel: ObservableObject {
  private var cardManager: ScryfallClient = ScryfallClient(networkLogLevel: .minimal)
  @Published var cardList: [Card] = []
  var pageCount = 1

  func cardsearchCompletion(result: Result<ObjectList<Card>, Error>) {
    switch result {
      case .success(let cards):
        DispatchQueue.main.async {
          self.cardList += cards.data
        }
      case .failure(let error):
        // TODO: Handle errors
        print(error.localizedDescription)
    }
  }

  func resetSearch() {
    pageCount = 1
    cardList.removeAll()
  }

  init() {
    cardManager.searchCards(filters: [], completion: cardsearchCompletion(result:))
  }

  func search(parameters: [CardFieldFilter], shouldResetSearch: Bool) {
    if shouldResetSearch {
      resetSearch()
    }
    cardManager.searchCards(filters: parameters, page: pageCount, completion: cardsearchCompletion(result:))
  }
}

/// This list is for pre-existing card lists such as a "deck" or a box.
/// A very similar list view will be used for searching. This is just for local
struct MTGCardSearchView: View {
  
  @ObservedObject var searchModel: MTGSearchModel
  
  @ObservedObject var filterViewModel: MTGFilterViewModel

  init() {
    searchModel = MTGSearchModel()
    filterViewModel = MTGFilterViewModel()
    filterViewModel.typeAction = fetchByParameter(parameters:)
  }

  func fetchByParameter(parameters: [CardFieldFilter]) {
    searchModel.search(parameters: parameters, shouldResetSearch: true)
  }

  var body: some View {
    VStack {
      MTGFilterView()
      Spacer()
      if #available(iOS 15.0, *) {
        List {
          ForEach(searchModel.cardList) {
            MTGCardListItem(card: $0)
              .listRowBackground(Color($0.cardColor))
              .listRowSeparator(.hidden)
          }
          Rectangle()
            .frame(width: 0, height: 0, alignment: .center)
            .task {
              searchModel.pageCount += 1
              searchModel.search(parameters: filterViewModel.activeFilters, shouldResetSearch: false)
            }
        }
      } else {
        ScrollView {
          LazyVStack {
            ForEach(searchModel.cardList) {
              MTGCardListItem(card: $0)
                .background(Color($0.cardColor))
            }
            Rectangle()
              .frame(width: 0, height: 0, alignment: .center)
              .onAppear() {
                searchModel.pageCount += 1
                searchModel.search(parameters: filterViewModel.activeFilters, shouldResetSearch: false)
              }
          }
        }
      }
      Spacer()
    }
    .environmentObject(filterViewModel)
  }
}

struct MTGCardSearchView_Previews: PreviewProvider {
  static func setUpPreview() -> some View {
    let list = MTGCardListView()
    list.cardList = MTGCardListItem_Previews.testData
    return list
  }
    static var previews: some View {
        setUpPreview()
    }
}
