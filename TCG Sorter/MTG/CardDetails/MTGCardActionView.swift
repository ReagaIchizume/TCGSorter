//
//  MTGCardActionView.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 5/10/24.
//

import SwiftUI

struct MTGCardActionView: View {
    var body: some View {
      VStack {
        HStack {
          Button("Dummy Action 1", action: {
            
          })
          .padding(6)
          Button("Dummy Action 2", action: {
            
          })
          .padding(6)
        }
        HStack {
          Button("Dummy Action 3", action: {
            
          })
          .padding(6)
          Button("Dummy Action 4", action: {
            
          })
          .padding(6)
        }
      }
    }
}

struct MTGCardActionView_Previews: PreviewProvider {
    static var previews: some View {
        MTGCardActionView()
    }
}
