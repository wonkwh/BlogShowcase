//
//  ButtonAnimationView.swift
//  BlogShowcase
//
//  Created by kwanghyun won on 2021/09/03.
//  Copyright © 2021 wonkwh. All rights reserved.
//

import SwiftUI

struct ButtonAnimationView: View {
  @State private var downloadButtonTapped = false
  @State private var isLoading = false
  @State private var isFullCircle = false
  @State private var isComplete = false
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 30)
        .trim(from: 0, to: self.isFullCircle ? 0.95 : 1)
        .stroke(lineWidth: 5)
        .frame(width: 300, height: 60)
        .foregroundColor(self.downloadButtonTapped ? .purple :
                          Color(red: 230/255, green: 230/255, blue: 230/255))
        .background(self.downloadButtonTapped ? .white:
                      Color(red: 230/255, green: 230/255, blue: 230/255))
        .cornerRadius(30)
        .rotationEffect(Angle(degrees: self.isLoading ? 0 : -1440))
        .onTapGesture {
          withAnimation(.default) {
            self.downloadButtonTapped = true
            self.isFullCircle = true
          }
        }
      
      if !downloadButtonTapped {
        HStack {
          Image(systemName: "guitars.fill")
            .resizable()
            .frame(width: 35, height: 30)
          Text("Enter")
        }
        .font(.headline)
        .onDisappear(perform: {
          self.startProcessing()
        })
      }
      
      if isComplete {
        CheckView()
          .offset(x: -5, y: 9)
          .foregroundColor(.purple)
      }
    }
  }
  
  func startProcessing() {
    withAnimation(Animation.linear(duration: 5)) {
      self.isLoading = true
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 4 ) {
      self.isComplete = true
      self.isFullCircle = false
    }
  }
}

struct ButtonAnimationView_Previews: PreviewProvider {
  static var previews: some View {
    ButtonAnimationView()
  }
}
