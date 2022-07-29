//
//  MTGCardSearchView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 7/15/22.
//

import SwiftUI
import MTGSDKSwift

class MTGSearchModel: ObservableObject {
  private var cardManager: MTGManager
  @Published var cardList: [Card] = []
  var pageCount = 1 {
    didSet {
      cardManager.page = pageCount
    }
  }

  func cardsearchCompletion(result: Result<[Card]>) {
    switch result {
      case .success(let cards):
        DispatchQueue.main.async {
          self.cardList += cards
        }
      case .error(let error):
        // TODO: Handle errors
        print(error.localizedDescription)
    }
  }

  func resetSearch() {
    pageCount = 1
    cardList.removeAll()
  }

  init(manager: MTGManager = PrimaryMTGManager()) {
    self.cardManager = manager
    manager.fetchAll(completion: cardsearchCompletion)
  }

  func search(parameters: [CardSearchParameter]) {
    cardManager.fetchBy(search: parameters, completion: cardsearchCompletion)
  }
}

/// This list is for pre-existing card lists such as a "deck" or a box.
/// A very similar list view will be used for searching. This is just for local
struct MTGCardSearchView: View {
  
  var cardManager: MTGManager
  @ObservedObject var searchModel = MTGSearchModel()
  
  @StateObject var filterViewModel: MTGFilterViewModel = MTGFilterViewModel()

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
            .frame(height: 0)
            .onAppear() {
              searchModel.pageCount += 1
              searchModel.search(parameters: filterViewModel.activeFilters)
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
              .frame(height: 0)
              .onAppear() {
                searchModel.pageCount += 1
                searchModel.search(parameters: filterViewModel.activeFilters)
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
