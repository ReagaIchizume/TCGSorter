//
//  CheckBoxStyle.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 8/12/22.
//

import SwiftUI

// Taken from holaux on Stack Overflow
// https://stackoverflow.com/questions/58425829/how-can-i-create-a-text-with-checkbox-in-swiftui
// Custom Toggle Style
struct CheckBoxToggleStyle: ToggleStyle {

  func makeBody(configuration: Configuration) -> some View {
        Button {
          configuration.isOn.toggle()
          print(configuration.isOn)
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
