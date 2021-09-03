//
//  AnotherCustomView.swift
//  BlogShowcase
//
//  Created by kwanghyun won on 2021/08/03.
//  Copyright © 2021 wonkwh. All rights reserved.
//

import SwiftUI

// https://www.youtube.com/watch?v=XdfVPPfnZZU
struct AnotherCustomView: View {
  var body: some View {
    Text("R&B소울")
      .tag(.fixedColor(color: Color.gray))
  }
}

struct AnotherCustomView_Previews: PreviewProvider {
  static var previews: some View {
    AnotherCustomView()
  }
}


struct Tag: ViewModifier {
  enum BGColor {
    case fixedColor(color: Color)
    case randomColor
  }
  
  let bgColor: BGColor
  let opacity: Double
  
  func body(content: Content) -> some View {
    let tagColor: Color
    switch bgColor {
    case .fixedColor(color: let color):
      tagColor = color
    case .randomColor:
      tagColor = Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
    return content
      .font(.system(size: 14, weight: .bold))
      .padding(8)
      .background(tagColor)
      .opacity(opacity)
      .foregroundColor(Color.black)
      .cornerRadius(8)
  }
}

extension View {
  func tag(_ bgColor: Tag.BGColor, opacity: Double = 1) -> some View {
    self.modifier(Tag(bgColor: bgColor, opacity: opacity))
  }
  
  // List
  func centerInList() -> some View {
    self.modifier(CenterInList())
  }
  
  func overlayCaption(caption: String) -> some View {
    self.modifier(OverlayCaption(caption: caption))
  }
}

extension Image {
  func displayImage(width: CGFloat) -> some View {
    self
      .resizable()
      .scaledToFit()
      .frame(width: width)
  }
}

struct CenterInList: ViewModifier {
  func body(content: Content) -> some View {
    HStack {
      Spacer()
      content
      Spacer()
    }
  }
}

struct OverlayCaption: ViewModifier {
  let caption: String
  func body(content: Content) -> some View {
    content
      .overlay(
        Text(caption)
          .tag(.fixedColor(color: .black), opacity: 0.6)
          .padding(5),
        alignment: .bottomTrailing
      )
  }
}
