//
//  CustomViewModifiers.swift
//  BlogShowcase
//
//  Created by wonkwh on 2020/11/26.
//  Copyright © 2020 wonkwh. All rights reserved.
//


import SwiftUI

struct ModifierStackView: View {
    var body: some View {
        HStack {
            CustomBlueButton()
            CustomRedButton()
            Button(action: {
                print("select button")
            }, label: {
                Text("Cancel")
                    .modifier(ButtonModifier(backgroundColor: .green))
            })
        }
    }
}

struct CustomBlueButton: View {
    var body: some View {
        Button(action: {
            print("select button")
        }, label: {
            Text("Continue")
                .modifier(ButtonModifier(backgroundColor: .blue))
        })
    }
}

struct CustomRedButton: View {
    var body: some View {
        Button(action: {
            print("select button")
        }, label: {
            Text("Okay")
                .modifier(ButtonModifier(backgroundColor: .red))
        })
    }
}

struct ButtonModifier: ViewModifier {
    @State var backgroundColor = Color.red
    
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 16))
            .foregroundColor(.white)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1))
                    .foregroundColor(Color(.sRGB, red: 0.1, green: 0.1, blue: 0.1, opacity: 1))
                    .cornerRadius(4)
                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 5, x: 0, y: 0)
            )
    }
}


struct CustomViewModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ModifierStackView()
    }
}
