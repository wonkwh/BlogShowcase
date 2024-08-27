//
//  ForceReload.swift
//  SwiftUITips
//
//  Created by ncn on 8/27/24.
//  Copyright © 2024 wonkwh. All rights reserved.
// https://juejin.cn/post/7284069963122720827

import SwiftUI

struct ForceReloadView: View {
  @ObservedObject var refreshTrigger = TriggerViewModel()

  var body: some View {
    VStack {
      Button("Reload") {
        updateViewModel()
      }
      .font(.headline)
      .buttonStyle(.borderedProminent)
      .padding()
      RandomView()
        .padding()
    }
  }

  private func updateViewModel() {
    refreshTrigger.updateView()
  }
}

struct RandomView: View {
  let randomColor = Color(
    hue: Double.random( in: 0...1 ),
    saturation: Double.random( in: 0...1 ),
    brightness: Double.random( in: 0...1 )
  )

  var body: some View {
    RoundedRectangle(cornerRadius: 12)
      .foregroundColor(randomColor)
  }
}

// - SwiftUI 상태 관리 `@ObservedObject` 의 라이프사이클은 뷰와 일치
// - 뷰가 다시 reload 될 때 관련된 `ObservedObject`도 다시 초기화
// - ObservedObject가 변경될 때도 뷰가 다시 reload
// -  ObservedObject 인스턴스를 커스텀하여 ObservedObject 상태 변화를 통해 뷰 를 새로고침 할 수 있다.

class TriggerViewModel: ObservableObject {
  func updateView() {
    self.objectWillChange.send()
  }
}

#Preview {
  ForceReloadView()
}
