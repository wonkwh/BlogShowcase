//
//  HttpMethod.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/09/14.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

enum HTTPContentType {
    case json(Encodable?)
    case urlEncoded(EncodableDictionary)

    var headerValue: String {
        switch self {
        case .json: return "application/json"
        case .urlEncoded: return "application/x-www-form-urlencoded"
        }
    }
}

enum HTTPMethod {
    case get([String: String]? = nil)
    case put(HTTPContentType)
    case post(HTTPContentType)
    case patch(HTTPContentType)
    case delete

    public var rawValue: String {
        switch self {
        case .get: return "GET"
        case .put: return "PUT"
        case .post: return "POST"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
}
