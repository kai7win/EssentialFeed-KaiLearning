//
//  FeedLoader.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/1.
//

import Foundation

public enum LoadFeedResult{
    case success([FeedItem])
    case failure(Error)
}


protocol FeedLoader{
    func load(completion:@escaping (LoadFeedResult) -> Void)
}
