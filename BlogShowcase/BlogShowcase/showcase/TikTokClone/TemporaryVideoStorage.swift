//
//  TemporaryVideoStorage.swift
//  BlogShowcase
//
//  Created by kwanghyun won on 2021/01/14.
//  Copyright © 2021 wonkwh. All rights reserved.
//

import Foundation

// MARK: - TemporaryVideoStorage

/// AVPlayer doesn't support playing videos from Data, that's why we temporary
/// store it on disk.
final class TemporaryVideoStorage {
    private let path: URL
    private let _queue = DispatchQueue(label: "com.github.wonkwh.TemporaryVideoStorage.Queue")

    // Ignoring error handling for simplicity.
    static let shared = try! TemporaryVideoStorage()

    init() throws {
        guard let root = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            throw NSError(domain: NSCocoaErrorDomain, code: NSFileNoSuchFileError, userInfo: nil)
        }
        self.path = root.appendingPathComponent("com.github.wonkwh.TemporaryVideoStorage", isDirectory: true)
        // Clear the contents that could potentially was left from the previous session.
        try? FileManager.default.removeItem(at: path)
        try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
    }

    func storeData(_ data: Data, _ completion: @escaping (URL) -> Void) {
        _queue.async {
            let url = self.path.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp4")
            try? data.write(to: url) // Ignore that write may fail in some cases
            DispatchQueue.main.async {
                completion(url)
            }
        }
    }

    func removeData(for url: URL) {
        _queue.async {
            try? FileManager.default.removeItem(at: url)
        }
    }

    func removeAll() {
        _queue.async {
            // Clear the contents that could potentially was left from the previous session.
            try? FileManager.default.removeItem(at: self.path)
            try? FileManager.default.createDirectory(at: self.path, withIntermediateDirectories: true, attributes: nil)
        }
    }
}
