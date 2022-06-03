//
//  ContentView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 2/8/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @ViewBuilder
  /// Defines view to navigate to when clicking the game name
  private func destination(for game: TCG) -> some View {
    switch game {
      case .mtg:
        MTGHomePage()
    }
  }
  
  var body: some View {
    // Defines enclosed List as capable of navigation
    NavigationView {
      List (TCG.allCases) { game in
        // Make a navigation link that pops up the home page for each game
        NavigationLink(destination: destination(for: game)) {
          // View visible to user. Clicking it goes to destination
          Text(game.rawValue)
        }
      }
    }
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
