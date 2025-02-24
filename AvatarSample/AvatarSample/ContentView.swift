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
      HStack(alignment: .top) {
        Image(person.profileImageName)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 75, height: 75, alignment: .center)
          .clipShape(.circle)
          .accessibilityLabel(person.fullName)

        VStack(alignment: .leading) {
          Text(person.fullName)
            .font(.headline)
          Text(person.jobtitle)
            .font(.subheadline)
          Text(person.affiliation)
            .font(.subheadline)
        }
      }
      .accessibilityElement(children: .contain)
      .accessibilityLabel(person.fullName)
    }
  }
}

#Preview {
  ContentView()
}
