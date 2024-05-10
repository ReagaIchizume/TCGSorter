//
//  MTGCardDetailView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 5/10/24.
//

import SwiftUI
import ScryfallKit
import Combine

class MTGCardImageProvider: ObservableObject {
  @Published var image = UIImage()
  private var cancellable: AnyCancellable?

  func loadImage(forCard card: Card) {
    guard let url = card.getImageURL(type: .normal) else { return }
    self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .receive(on: DispatchQueue.main)
      .compactMap { UIImage(data: $0.data) }
      .sink(receiveCompletion: { failure in
        print(failure)
      }, receiveValue: { image in
        self.image = image
      })
    
  }
}

struct MTGCardDetailView: View {
  let card: Card
  @StateObject var imageProvider = MTGCardImageProvider()
  var body: some View {
    VStack(alignment: .center) {
      Image(uiImage: imageProvider.image)
        .resizable()
        .padding(6)
        .onAppear {
          self.imageProvider.loadImage(forCard: self.card)
        }
      MTGCardActionView()
    }
  }
}

struct MTGCardDetailView_Previews: PreviewProvider {
  static var previews: some View {
    MTGCardDetailView(card: Card(name: "", type: "", manaCost: ""))
  }
}
