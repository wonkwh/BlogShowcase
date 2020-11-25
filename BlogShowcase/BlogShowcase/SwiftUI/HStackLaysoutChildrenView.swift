//
//  HStackLaysoutChildrenView.swift
//  BlogShowcase
//
//  Created by kwanghyun.won on 2020/11/25.
//  Copyright © 2020 wonkwh. All rights reserved.
//
// // https://www.objc.io/blog/2020/11/09/hstacks-child-ordering/


import SwiftUI


struct HStackLaysoutChildrenView: View {
    var body: some View {
        HStack(spacing: 0) {
            Rectangle().fill(Color.red).measure()
            Rectangle().fill(Color.blue)
            Rectangle().fill(Color.green)
        }.frame(width: 300, height: 100)

        HStack(spacing: 0) {
            Rectangle().fill(Color.red).frame(maxWidth: 100).measure()
            Rectangle().fill(Color.green).frame(minWidth: 100).measure()
        }.frame(width: 150, height: 100)

        HStack(spacing: 0) {
            Rectangle().fill(Color.red).frame(maxWidth: 100).measure()
            Rectangle().fill(Color.green).frame(minWidth: 90, maxWidth: 200).measure()
        }
        .frame(width: 150, height: 100)
    }
}

extension View {
    func measure() -> some View {
        overlay(GeometryReader { proxy in
            Text("\(Int(proxy.size.width) )")
        })
    }
}

struct HStackLaysoutChildrenView_Previews: PreviewProvider {
    static var previews: some View {
        HStackLaysoutChildrenView()
    }
}
