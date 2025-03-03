//
//  ContentView.swift
//  AvatarSample
//
//  Created by ncn on 2/15/25.
//

import SwiftUI

struct ContentView: View {
  @State var people = Person.samples
  @State var participants = Person.samples.filter { $0.isParticipant }
  var body: some View {
    List {
      Section("participants") {
        ForEach(participants) { person in
          AvatarRowView(person: person)
        }
      }
      
      Section("speacker") {
        ForEach(people) { person in
          AvatarRowView(person: person)
            .avatarImageShape(.round)
        }
      }
    }
    .avatarImageShape(.square)
  }
}

#Preview {
  ContentView()
}

