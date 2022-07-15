//
//  MTGCardSearchView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 7/15/22.
//

import SwiftUI
import MTGSDKSwift

class MTGSearchModel {
  private var cardManager: MTGManager
  var cardList: [Card] = MTGCardListItem_Previews.testData

  func cardsearchCompletion(result: Result<[Card]>) {
    switch result {
      case .success(let cards):
        cardList = cards
      case .error(let error):
        // TODO: Handle errors
        print(error.localizedDescription)
    }
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
  @State var searchModel = MTGSearchModel()
  
  @StateObject var filterViewModel: MTGFilterViewModel = MTGFilterViewModel()

  var body: some View {
    VStack {
      MTGFilterView()
      Spacer()
      if #available(iOS 15.0, *) {
        List(searchModel.cardList) {
            MTGCardListItem(card: $0)
              .listRowBackground(Color($0.cardColor))
              .listRowSeparator(.hidden)
        }
      } else {
        ScrollView {
          LazyVStack {
            ForEach(searchModel.cardList) {
              MTGCardListItem(card: $0)
                .background(Color($0.cardColor))
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
