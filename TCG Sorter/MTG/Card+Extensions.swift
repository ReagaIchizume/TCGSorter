//
//  Card+Extensions.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import Foundation
import MTGSDKSwift

extension Card: Identifiable {
  var isLand: Bool {
    return types?.map { $0.lowercased() }.contains("land") ?? false
  }
}
