//
//  FacebookLayoutView.swift
//  BlogShowcase
//
//  Created by wonkwh on 2020/11/23.
//  Copyright © 2020 wonkwh. All rights reserved.
//

// https://www.letsbuildthatapp.com/course_video?id=5202
import SwiftUI

struct Post {
    let id: Int
    let username, text, profileImageName, imageName: String
    
    static let samplePosts: [Post] = [
        .init(id: 1, username: "Bill Clinton", text: "I swear I didn't touch that girl, she came on to me!", profileImageName: "burger", imageName: "post_puppy"),
        .init(id: 2, username: "Barack Obama", text: "I used to be the president that people claimed wasn't born in the United States, but that isn't true", profileImageName: "burger", imageName: "burger"),
        .init(id: 1, username: "Bill Clinton", text: "I swear I didn't touch that girl, she came on to me!", profileImageName: "burger", imageName: "post_puppy"),
        .init(id: 2, username: "Barack Obama", text: "I used to be the president that people claimed wasn't born in the United States, but that isn't true", profileImageName: "burger", imageName: "burger")
    ]
}

struct Group {
    let id: Int
    let name, imageName: String
    
    static let sampleGroups: [Group] = [
        .init(id: 1, name: "Co-Ed Hikes of Colorado", imageName: "hike"),
        .init(id: 2, name: "Other People's Puppies", imageName: "puppy"),
        .init(id: 3, name: "Secrets to Seasonal Gardening", imageName: "gardening"),
        .init(id: 4, name: "Co-Ed Hikes of Colorado", imageName: "hike"),
        .init(id: 5, name: "Other People's Puppies", imageName: "puppy"),
         .init(id: 6, name: "Secrets to Seasonal Gardening", imageName: "gardening"),
         .init(id: 7, name: "Co-Ed Hikes of Colorado", imageName: "burger"),
         .init(id: 8, name: "Other People's Puppies", imageName: "burger")
    ]
}


struct GroupDetailView: View {
    let group: Group
    var body: some View {
        VStack {
            Image(group.imageName)
            Text(group.name)
        }.navigationBarTitle(Text(group.name))
    }
}

struct GroupView: View {
    let group: Group
    var body: some View {
        VStack {
            Image(group.imageName).renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(5).clipped()
            Text(group.name)
                .foregroundColor(.primary)
                .lineLimit(2)
                .frame(width: 100, height: 50, alignment: .leading)
                .font(.headline)
        }
    }
}

struct PostView: View {
    let post: Post
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            HStack {
                Image("burger").resizable().frame(width: 50, height: 50).clipShape(Circle()).clipped()
                VStack (alignment: .leading) {
                    Text(post.username).font(.headline)
                    Text("Posted 8 hrs ago").font(.body)
                    }.padding(.leading, 8)
                }.padding(.leading, 16)
            Text(post.text).padding(.leading, 16).padding(.trailing, 36).lineLimit(nil)
            
            Image(post.imageName, bundle: nil)
                .scaledToFill()
                .frame(height: 300)
                .clipped()
            }.padding(.leading, -20).padding(.trailing, -20).padding(.top, 12).padding(.bottom, -26)
    }
}

struct FacebookLayoutView: View {
    let posts = Post.samplePosts

    var body: some View {
        NavigationView {
            List {
                VStack (alignment: .leading) {
                    Text("Trending")
                        .font(.headline)
                        .padding(.leading, 16)
                        .padding(.bottom, 4)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Group.sampleGroups, id: \.imageName) { group in
                                NavigationLink(destination: GroupDetailView(group: group)) {
                                    GroupView(group: group).padding(.trailing, 8)
                                }
                            }
                        }.padding(.leading, 16).padding(.trailing, 8)
                    }.frame(height: 180)
                }.padding(.top, 8).padding(.leading, -20).padding(.trailing, -20)
                
                ForEach(posts, id: \.id) { post in
                    PostView(post: post).padding(.bottom)
                }
            }.navigationBarTitle(Text("Groups"), displayMode: .automatic)
        }
        
    }}


#if DEBUG
struct FacebookLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        FacebookLayoutView()
    }
}
#endif
