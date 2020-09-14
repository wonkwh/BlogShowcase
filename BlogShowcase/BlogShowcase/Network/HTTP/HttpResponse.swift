//
//  HttpResponse.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/09/14.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

struct HTTPResponse<T: Decodable> {
    let route: RouteProvider
    let response: HTTPURLResponse?
    let data: Data?

    var decoded: T? {
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
