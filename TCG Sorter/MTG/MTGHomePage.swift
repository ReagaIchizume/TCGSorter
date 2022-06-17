//
//  MTGHomePage.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 6/3/22.
//

import SwiftUI

struct MTGHomePage: View {
  var body: some View {
    VStack {
      // Already in a navigationView by now, no need to make a new one.
      NavigationLink(destination: MTGCardListView(manager: PrimaryMTGManager())) {
        Text("Browse Cards")
      }
    }
  }
}

struct MTGHomePage_Previews: PreviewProvider {
  static var previews: some View {
    MTGHomePage()
  }
}
