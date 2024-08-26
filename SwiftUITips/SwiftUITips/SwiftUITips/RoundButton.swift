//
//  RoundButton.swift
//  SwiftUITips
//
//  Created by ncn on 8/26/24.
//  Copyright © 2024 wonkwh. All rights reserved.
//
// https://dev.jeremygale.com/avoid-these-common-errors-when-switching-from-uikit-to-swiftui

import Combine
import SwiftUI

struct RoundButton: View {

  let title: String
  var titleColor = Color.black
  var fillColor = Color(white: 0.8)

//  @State private var textColor = Color.black
//  @State private var backgroundColor = Color(white: 0.8)

  var textColor: Color {
    titleColor.opacity(isActive ? 1 : 0.4)
  }

  var backgroundColor: Color {
    fillColor.opacity(isActive ? 1 : 0.4)
  }

  // 아래 두 변수는 @Binding으로 변경할 필요가 없다, 업데이트 하는 부분은 없고 읽기만 하기 때문
  let isLoading: Bool
  let isActive: Bool

  var action: () -> Void

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Button(action: isActive ? action : {}) {
          Text(isLoading ? "" : title)
            .foregroundColor(textColor)
            .font(.system(size: 16))
            .multilineTextAlignment(.center)
            .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .center
            )
        }
        if isLoading {
          LoadingCircle()
            .frame(height: geometry.size.height / 2)
        }
      }
      .frame(
        width: geometry.size.width,
        height: geometry.size.height,
        alignment: .center
      )
      .background {
        backgroundColor
          .clipShape(Capsule(style: .circular))
      }
    }
    .frame(width: 220, height: 48)
  }
}

struct LoadingCircle: View {
  @State private var isAnimating: Bool = false

  var body: some View {
    Circle()
      .trim(from: 0.0, to: 0.7)
      .stroke(Color.gray, lineWidth: 3)
      .frame(width: .infinity, height: .infinity)
      .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
      .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: isAnimating)
      .onAppear {
        self.isAnimating = true
      }
  }
}

struct PreviewWrapper: View {
  var body: some View {
    VStack(spacing: 30) {
      RoundButton(
        title: "Continue",
        isLoading: false,
        isActive: true
      ) {}
      RoundButton(
        title: "Disabled",
        isLoading: false,
        isActive: false
      ) {}
      RoundButton(
        title: "Continue to step 2",
        isLoading: false,
        isActive: true
      ) {}
      RoundButton(
        title: "Continue to step 2",
        isLoading: true,
        isActive: true
      ) {}
      Spacer()
    }
  }
}

#Preview {
  PreviewWrapper()
}

#Preview("Dark mode") {
  PreviewWrapper()
    .previewDisplayName("Dark mode")
    .preferredColorScheme(.dark)
}

#Preview("Dynamic type") {
  PreviewWrapper()
    .previewDisplayName("Dynamic Type")
    .environment(\.sizeCategory, .accessibilityExtraLarge)
}
