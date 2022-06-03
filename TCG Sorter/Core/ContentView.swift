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
  private func destination(for game: TCG) -> some View {
    switch game {
      case .mtg:
        MTGHomePage()
    }
  }
  
  var body: some View {
    NavigationView {
      List (TCG.allCases) { game in
        NavigationLink(destination: destination(for: game)) {
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
