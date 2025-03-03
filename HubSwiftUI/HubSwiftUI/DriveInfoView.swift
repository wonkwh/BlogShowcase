//
//  DriveInfoView.swift
//  HubSwiftUI
//
//  Created by ncn on 2/25/25.
//

import SwiftUI

struct LiveInfoView: View {
  @State var isHidden = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      TitleView()
      DriveInfoView()
//      ChartView()
    }
    .padding()
    .background(Color.white)
    .cornerRadius(5)
  }
  
  init() {
  }
}


struct DriveInfoView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(spacing: 5) {
        DriveInfoItemView(title: "Driving Distance", value: "269 Mile")
        DriveInfoItemView(title: "Top Speed", value: "160 km/h")
      }
      
      HStack(spacing: 5) {
        DriveInfoItemView(title: "Impact Recording", value: "0 Times")
        DriveInfoItemView(title: "Average Speed", value: "100 km/h")
      }
    }
  }
}


struct DriveInfoItemView: View {
  var title: String
  var value: String

  var body: some View {
    HStack {
      Text(title)
        .font(.caption)
        .foregroundColor(.subText)
      Spacer()
      Text(value)
        .font(.caption)
        .foregroundColor(.subText)
    }
    .padding(.horizontal, 6)
    .padding(.vertical, 8)
    .background(Color.background)
    .cornerRadius(5)
  }
}

#Preview("DriveInfoView") {
  // background color
  LiveInfoView()
}


