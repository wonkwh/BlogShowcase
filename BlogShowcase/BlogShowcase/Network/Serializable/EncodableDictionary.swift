//
//  EncodableDictionary.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/09/14.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

//This protocol URL encodes Dictionary keys and values and returns them as Data. Input: [“Name”: “kwanghyun W”, “Emoji”: “🍩”]
//Output: Name=kwanghyun%20W&Emoji=%F0%9F%8D%A9 (string representation of data)

protocol EncodableDictionary {
    var asURLEncodedString: String? { get }
    var asURLEncodedData: Data? { get }
}

extension Dictionary: EncodableDictionary {

    var asURLEncodedString: String? {
        var pairs: [String] = []
        for (key, value) in self {
            pairs.append("\(key)=\(value)")
        }
        return pairs
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }

    var asURLEncodedData: Data? { asURLEncodedString?.data(using: .utf8) }
}


