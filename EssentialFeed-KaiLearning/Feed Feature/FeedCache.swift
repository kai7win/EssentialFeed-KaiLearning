//
//  FeedCache.swift
//  EssentialFeed-KaiLearning
//
//  Created by Kai Chi Tsao on 2023/4/14.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedImage]) throws
}
