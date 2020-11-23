//
//  DynamicListView.swift
//  BlogShowcase
//
//  Created by wonkwh on 2020/11/23.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import SwiftUI

struct User: Identifiable {
    let id: Int
    let name, message, imageName: String
}

struct DynamicsListView: View {
    
    let users: [User] = [
        .init(id: 0, name: "Tim Cook", message: "My stands cost $999", imageName: "tim_cook"),
        .init(id: 1, name: "Craig Federighi", message: "I have the sexiest hair in the land of Apple spokesmen", imageName: "craig_f"),
        .init(id: 2, name: "Jony Ive", message: "Somebody save me, I have no idea where I am anymore. Do I even work at Apple anymore? I bet you sure miss my sexy ass accent during the keynotes, amiright?", imageName: "jon_ivey")
    ]
    
    var body: some View {
        NavigationView {
            List (users) {
                UserView(user: $0)
            }.navigationBarTitle(Text("Dynamic List"))
        }
    }
}

struct UserView: View {
    let user: User
    var body: some View {
        HStack {
            Image(user.imageName)
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
                .frame(width: 70, height: 70)
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name).font(.headline)
                Text(user.message).font(.subheadline).lineLimit(nil)
                }.padding(.leading, 8)
            }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

#if DEBUG
struct DynamicsListViewPreviews: PreviewProvider {
    static var previews: some View {
        DynamicsListView()
    }
}

#endif
