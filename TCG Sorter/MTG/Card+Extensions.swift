//
//  Card+Extensions.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import UIKit
import ScryfallKit

extension Card {
  /// Mostly for tests, the ability to set a card's displayable quantities
  public init(
    name: String,
    type: String,
    manaCost: String?,
    colors: [Color] = [],
    colorIdentity: [Color] = []
  ) {
    self.init(arenaId: nil, mtgoId: nil, mtgoFoilId: nil, multiverseIds: nil, tcgplayerId: nil, tcgplayerEtchedId: nil, cardMarketId: nil, id: UUID(), oracleId: "", lang: "", printsSearchUri: "", rulingsUri: "", scryfallUri: "", uri: "", allParts: nil, cardFaces: nil, cmc: 0, colorIdentity: colorIdentity, colorIndicator: nil, colors: colors, edhrecRank: nil, handModifier: nil, keywords: [], layout: Layout.normal, legalities: Legalities(standard: Legality.legal, historic: .legal, pioneer: .legal, modern: .legal, legacy: .legal, pauper: .legal, vintage: .legal, penny: .legal, commander: .legal, brawl: .legal), lifeModifier: nil, loyalty: nil, manaCost: manaCost, name: name, oracleText: nil, oversized: false, power: nil, producedMana: nil, reserved: false, toughness: nil, typeLine: type, artist: nil, booster: false, borderColor: .black, cardBackId: nil, collectorNumber: "", contentWarning: nil, digital: false, finishes: [], flavorName: nil, flavorText: nil, frameEffects: nil, frame: Frame.v2015.rawValue, fullArt: false, games: [], highresImage: false, illustrationId: nil, imageStatus: .missing, imageUris: nil, prices: Prices(), printedName: nil, printedText: nil, printedTypeLine: nil, promo: false, promoTypes: nil, purchaseUris: nil, rarity: .common, relatedUris: [:], releasedAt: "", reprint: false, scryfallSetUri: "", setName: "", setSearchUri: URL(string: "")!, setType: .core, setUri: "", set: "", storySpotlight: false, textless: false, variation: false, variationOf: nil, watermark: nil, preview: nil)
  }
  var isLand: Bool {
    return typeLine?.lowercased().contains("land") ?? false
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
