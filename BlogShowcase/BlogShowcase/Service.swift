//
//  Service.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/03/15.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    var screenshotUrls: [String]?
    let artworkUrl100: String // app icon
    var formattedPrice: String?
    var description: String?
    var releaseNotes: String?
    var artistName: String?
    var collectionName: String?
}

protocol ResultViewData {
    var title: String { get }
    var subtitle: String { get }
    var albumCoverURL: URL? { get }
}


extension Result: ResultViewData {
    var title: String {
        return trackName
    }

    var subtitle: String {
        return "\(artistName ?? "") • \(collectionName ?? "")"
    }

    var albumCoverURL: URL? {
        return URL(string: artworkUrl100)
    }
}

class Service {
    static var shared = Service()

    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
