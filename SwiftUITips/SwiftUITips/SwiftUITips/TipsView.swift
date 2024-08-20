//
//  TipsView.swift
//  SwiftUITips
//
//  Copyright © 2024 wonkwh. All rights reserved.
//

import SwiftUI

struct Tips2View: View {
  var body: some View {
    Color.indigo
      .frame(width: 250, height: 250)
    // 다음과 같이 the cornerRadius(_:) view modifier. 를 교체 
      .clipShape(RoundedRectangle(cornerRadius: 25))
//      .cornerRadius(24)
  }
}

#Preview {
  Tips2View()
}
