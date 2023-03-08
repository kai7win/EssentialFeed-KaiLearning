//
//  FeedLoader.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/1.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader{
    func load(completion:@escaping (LoadFeedResult) -> Void)
}
