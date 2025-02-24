//
//  ContentView.swift
//  AvatarSample
//
//  Created by ncn on 2/15/25.
//

import SwiftUI

struct ContentView: View {
  @State var people = Person.samples
  var body: some View {
    List(people) { person in
      AvatarRowView(person: person)
    }
  }
}

#Preview {
  ContentView()
}

