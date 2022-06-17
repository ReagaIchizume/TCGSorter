//
//  MTGCardListView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import SwiftUI
import MTGSDKSwift

struct MTGCardListView: View {
  
  init(manager: MTGManager) {
    self.cardManager = manager
  }
  
  var cardManager: MTGManager
  @State var cardList: [Card] = MTGCardListItem_Previews.testData

  var body: some View {
    VStack {
      MTGFilterView(viewModel: MTGFilterViewModel())
      Spacer()
      if #available(iOS 15.0, *) {
        List {
          ForEach(cardList) {
            MTGCardListItem(card: $0)
              .listRowBackground(Color($0.cardColor))
              .listRowSeparator(.hidden)
          }
        }
      } else {
        ScrollView {
          LazyVStack {
            ForEach(cardList) {
              MTGCardListItem(card: $0)
                .background(Color($0.cardColor))
            }
          }
        }
      }
      Spacer()
    }
  }
}

class PreviewManager: MTGManager {

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
        case .error(let error):
          break
      }
    }
    return list
  }
    static var previews: some View {
        setUpPreview()
    }
}
