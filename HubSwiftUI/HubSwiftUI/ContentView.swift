//
//  ContentView.swift
//  HubSwiftUI
//
//  Created by ncn on 2/12/25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    HStack(spacing: 2) {
      ChannelMarkView(type: .front)
      ChannelMarkView(type: .rear)
      ChannelMarkView(type: .internal)
    }
  }
}

struct ChannelMarkView: View {

  enum ChannelType: String {
    case front = "F"
    case rear = "R"
    case `internal` = "I"
    case inf = "" 
    case event = "E"
    case park = "P"
  }

  @State var type: ChannelType = .front

  var body: some View {
    ZStack {
      Text(type.rawValue)
        .fontWeight(.bold)
        .padding(.vertical, 4.0)
        .foregroundStyle(Color.vueroidBlue)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .minimumScaleFactor(0.5)
    }
    .frame(width: 12.0, height: 15.0)
    .background(Color.blue10)
    .cornerRadius(2)
  }
}

#Preview {
  //  ContentView()
  HStack(spacing: 2) {
    ChannelMarkView(type: .front)
    ChannelMarkView(type: .rear)
    ChannelMarkView(type: .internal)
  }
}
