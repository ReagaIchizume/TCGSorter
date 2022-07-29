//
//  MTGManager.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import Foundation
import MTGSDKSwift

protocol MTGManager {
  func fetchAll(completion: @escaping Magic.CardCompletion)
  func fetchBy(search activeFilters: [CardSearchParameter], completion: @escaping Magic.CardCompletion)
  func fetchImage(for card: Card, completion: @escaping Magic.CardImageCompletion)
  var page: Int { get set }
}

class PrimaryMTGManager: MTGManager {
  private let magic = Magic()
  var page = 1
  private var configuration: MTGSearchConfiguration {
    MTGSearchConfiguration(pageSize: 100, pageTotal: page)
  }
  
  func fetchAll(completion: @escaping Magic.CardCompletion) {
    magic.fetchCards([], configuration: configuration, completion: completion)
  }
  
  func fetchBy(search activeFilters: [CardSearchParameter], completion: @escaping Magic.CardCompletion) {
    magic.fetchCards(activeFilters, configuration: configuration, completion: completion)
  }

  func fetchImage(for card: Card, completion: @escaping Magic.CardImageCompletion) {
    magic.fetchImageForCard(card, completion: completion)
  }
}
