//
//  RouteProvider.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/09/14.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

protocol RouteProvider {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
}

enum ITunesApiRoute {
    case searchResult
}

extension ITunesApiRoute: RouteProvider {
    var baseURL: URL {
        guard let url = URL(string: "https://itunes.apple.com") else {
            fatalError("Base URL could not be configured.")
        }
        return url
    }

    var path: String {
        switch self {
        case .searchResult: return "/search"
        }
    }

    var method: HTTPMethod {
        switch self {
        //"https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
        case .searchResult:
            return .get(["term": "IU", "offset": "0", "limit": "20"])
        }
    }

    var headers: [String : String] {
        return [:]
    }
}
