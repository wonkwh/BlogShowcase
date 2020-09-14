//
//  Client.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/09/14.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Combine
import Foundation

protocol HTTPClient {
    associatedtype Route: RouteProvider
    func request<T: Decodable>(_ model: T.Type,
                               from route: Route,
                               urlSession: URLSession) -> AnyPublisher<HTTPResponse<T>, HTTPError>
}

final class Client<Route: RouteProvider>: HTTPClient {

    func request<T>(_ model: T.Type,
                    from route: Route,
                    urlSession: URLSession = .shared) -> AnyPublisher<HTTPResponse<T>, HTTPError> {
        fatalError("Not implemented yet")
    }

}
