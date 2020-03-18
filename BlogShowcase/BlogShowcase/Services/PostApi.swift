//
//  PostApi.swift
//  BlogShowcase
//
//  Created by ios_dev on 2020/03/18.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import Foundation
import DeepDiff

// MARK: - Datum
public struct ThreadPost: Model,DiffAware  {
    public let id: String
    public let voteScore, commentCount, readAt: Int
    public let parentID, author: String
    public let edited: Bool
    public let createdAt: Int
    public let title: String
    public let deleted: Bool
    public let relation: Relation
    public let updatedAt: Int
    public let content: [Content]
    public let latest: String?

    enum CodingKeys: String, CodingKey {
        case id
        case voteScore = "vote_score"
        case commentCount = "comment_count"
        case readAt = "read_at"
        case parentID = "parent_id"
        case author, edited
        case createdAt = "created_at"
        case title, deleted, relation
        case updatedAt = "updated_at"
        case content, latest
    }
}


// MARK: - Content
public struct Content: Model {
    public let type: ContentType
    public let content: String?
    public let files: [File]?

    public init(type: ContentType, content: String?, files: [File]?) {
        self.type = type
        self.content = content
        self.files = files
    }
}

// MARK: - File
public struct File: Model {
    public let title, id: String

    public init(title: String, id: String) {
        self.title = title
        self.id = id
    }
}

public enum ContentType: String, Model {
    case file = "file"
    case text = "text"
}


// MARK: - Relation
public struct Relation: Model {
    public let vote: Vote

    public init(vote: Vote) {
        self.vote = vote
    }
}


// MARK: - Vote
public struct Vote: Model {
    public let type, createdAt: Int

    public init(type: Int, createdAt: Int) {
        self.type = type
        self.createdAt = createdAt
    }
}

// MARK: - URLSession response handlers

public extension URLSession {
    fileprivate func codableTask<T: Model>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        var request = URLRequest(url: url)
        let token =
        """
            vgut-G06MDWNKH-UCTCG3BN8-1582614936200-4bee0e2514b891a11e688b5a3138043a026f986376fb5b7f1a86f58da25cae52
        """
        let trimmdToken = token.trimmingCharacters(in: .whitespaces)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(trimmdToken)", forHTTPHeaderField: "Authorization")

        return self.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? JSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func postListTask(with url: URL, completionHandler: @escaping (PagedResults<ThreadPost>?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

