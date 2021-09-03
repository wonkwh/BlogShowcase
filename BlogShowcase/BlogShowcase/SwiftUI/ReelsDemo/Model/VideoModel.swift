//
//  VideoModel.swift
//  BlogShowcase
//
//  Created by kwanghyun won on 2021/07/01.
//  Copyright © 2021 wonkwh. All rights reserved.
//

import Foundation
import SwiftUI


// Sample Model and reels video
struct VideoModel: Identifiable {
  var id = UUID()
  var url: String
  var title: String
  var isExpanded: Bool = false
}

var VideoModelJSON = [
  VideoModel(url: "Sample1", title: "Apple AirTag."),
  VideoModel(url: "Sample2", title: "Apple AirTag.."),
  VideoModel(url: "Sample3", title: "Apple AirTag..."),
  VideoModel(url: "Sample4", title: "Apple AirTag...."),
  VideoModel(url: "Sample5", title: "Apple AirTag.....")
]
