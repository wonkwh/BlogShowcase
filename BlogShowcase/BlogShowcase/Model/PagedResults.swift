//
//  PagedResults.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/03/18.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

public protocol Model : Codable, Hashable {
    static var decoder: JSONDecoder { get }
    static var encoder: JSONEncoder { get }
}

public extension Model {
    // by default use a basic decoder
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
}

// A type that represents no model value is present
public struct Empty : Codable {
}



public struct PagedResults<Item : Model> : Model {
    let paging: Paging
    let data: [Item]
}


// MARK: - Paging
public struct Paging: Model {
    public let before: String?
    public let after: String?

}
