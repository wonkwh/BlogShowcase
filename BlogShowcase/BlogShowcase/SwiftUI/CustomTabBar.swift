//
//  CustomTabBar.swift
//  BlogShowcase
//
//  Created by kwanghyun won on 2021/01/13.
//  Copyright © 2021 wonkwh. All rights reserved.
//

import SwiftUI

// https://www.youtube.com/watch?v=9lVLFlyaiq4
struct CustomTabBar: View {
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
    }
    
    @State var selectedIndex = 0
    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                case 0:
                    Text("First")
                default:
                    Text("Remaining tabs")
                }
                
                
            }
        }
    }
}

//TabView {
//    Text("First").tabItem {
//        Image(systemName: "person")
//        Text("First")
//    }
//
//    Text("Second").tabItem {
//        Image(systemName: "gear")
//        Text("Second")
//    }
//}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
