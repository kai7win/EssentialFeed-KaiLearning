//
//  FeedImageDataCache.swift
//  EssentialFeed-KaiLearning
//
//  Created by Kai Chi Tsao on 2023/4/14.
//

import Foundation

public protocol FeedImageDataCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
}
