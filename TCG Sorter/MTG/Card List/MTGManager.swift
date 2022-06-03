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
}

class PrimaryMTGManager: MTGManager {
    private let magic = Magic()

    func fetchAll(completion: @escaping Magic.CardCompletion) {
        magic.fetchCards([], completion: completion)
    }
}
