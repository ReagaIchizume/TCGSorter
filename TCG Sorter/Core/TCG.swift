//
//  TCG.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import Foundation

public enum TCG: String, CaseIterable, Identifiable {
  public var id: String { UUID().uuidString }
  case mtg = "Magic The Gathering"
}
