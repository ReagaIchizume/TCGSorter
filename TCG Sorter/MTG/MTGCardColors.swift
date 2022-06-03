//
//  MTGCardColors.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import Foundation
import MTGSDKSwift
import SwiftHEXColors

enum MTGColor: Equatable {
  case white, blue, black, red, green, none, multi
  
  static func color(from colors: [String]) -> MTGColor {
    switch colors.count {
      case 1:
        // Count over zero, should never be nil
        guard let identity = colors.first else { return .none}
        switch identity {
          case "white":
            return .white
          case "blue":
            return .blue
          case "black":
            return .black
          case "red":
            return .red
          case "green":
            return .green
          default:
            return .none
        }
      case let identity where identity > 1:
        return .multi
      default:
        return .none
    }
  }
}

extension Card {
  // Enum representation of color identity (including rules text)
  var mtgColorIdentity: MTGColor {
    MTGColor.color(from: colorIdentity ?? [])
  }
  
  // Enum representation of casting cost
  var mtgColor: MTGColor {
    MTGColor.color(from: colors ?? [])
  }
}

extension UIColor {

  // Force-unwrapping colors, they should never be nil.
  static var mtgWhite: UIColor = UIColor(hexString: "#f3f4e7")!
  static var mtgBlue: UIColor = UIColor(hexString: "#6683af")!
  static var mtgBlack: UIColor = UIColor(hexString: "#4c4942")!
  static var mtgRed: UIColor = UIColor(hexString: "#5e1106")!
  static var mtgGreen: UIColor = UIColor(hexString: "#3c5c3a")!
  static var mtgVoid: UIColor = UIColor(hexString: "#666869")!
  static var mtgGold: UIColor = UIColor(hexString: "#e1d3a7")!
  static var mtgLand: UIColor = UIColor(hexString: "#c6c4c2")!

}
