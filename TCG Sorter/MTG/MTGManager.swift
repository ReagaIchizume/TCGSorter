//
//  MTGManager.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import Foundation
import MTGSDKSwift

public protocol MTGManager {
  func fetchAll(completion: @escaping Magic.CardCompletion)
}

public class PrimaryMTGManager: MTGManager {
    private let magic = Magic()

    public func fetchAll(completion: @escaping Magic.CardCompletion) {
        magic.fetchCards([], completion: completion)
    }
}
