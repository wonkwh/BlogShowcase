//
//  Service.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/03/15.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation


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
