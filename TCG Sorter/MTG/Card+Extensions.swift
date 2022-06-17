//
//  Card+Extensions.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import Foundation
import MTGSDKSwift

extension Card: Identifiable {
  /// Mostly for tests, the ability to set a card's displayable quantities
  public init(name: String, type: String, manaCost: String?, colors: [String] = []) {
    self.init()
    self.id = name
    self.name = name
    self.type = type
    self.manaCost = manaCost
    self.colors = colors
  }
  var isLand: Bool {
    return type?.lowercased().contains("land") ?? false
  }

  var cardColor: UIColor {
    if isLand {
      return .mtgLand
    }
    switch mtgColor {
      case .white:
        return .mtgWhite
      case .blue:
        return .mtgBlue
      case .black:
        return .mtgBlack
      case .red:
        return .mtgRed
      case .green:
        return .mtgGreen
      case .multi:
        return .mtgGold
      case .none:
        return .mtgVoid
    }
  }
}
