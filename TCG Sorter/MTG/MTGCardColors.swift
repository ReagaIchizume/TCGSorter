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
  static var mtgWhite: UIColor = #colorLiteral(red: 0.9219130278, green: 0.9196357757, blue: 0.8998702152, alpha: 1)
  static var mtgBlue: UIColor = #colorLiteral(red: 0.747289598, green: 0.7984774709, blue: 0.8900906444, alpha: 1)
  static var mtgBlack: UIColor = #colorLiteral(red: 0.6827152371, green: 0.6617467999, blue: 0.7114391923, alpha: 1)
  static var mtgRed: UIColor = #colorLiteral(red: 0.9481737018, green: 0.8238952756, blue: 0.7686375976, alpha: 1)
  static var mtgGreen: UIColor = #colorLiteral(red: 0.7158487439, green: 0.7849991918, blue: 0.760569036, alpha: 1)
  static var mtgVoid: UIColor = #colorLiteral(red: 0.8703830838, green: 0.8739280105, blue: 0.9071862102, alpha: 1)
  static var mtgGold: UIColor = #colorLiteral(red: 0.794490993, green: 0.7160476446, blue: 0.5352340937, alpha: 1)
  static var mtgLand: UIColor = #colorLiteral(red: 0.7775816321, green: 0.7675945163, blue: 0.7596909404, alpha: 1)
  static var mtgTextColor: UIColor = #colorLiteral(red: 0.3154934943, green: 0.2485016286, blue: 0.1023279503, alpha: 1)

}
