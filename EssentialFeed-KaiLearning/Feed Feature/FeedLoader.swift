//
//  FeedLoader.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/1.
//

import Foundation

public enum LoadFeedResult<Error:Swift.Error>{
    case success([FeedItem])
    case failure(Error)
}


protocol FeedLoader{
    associatedtype Error: Swift.Error
    func load(completion:@escaping (LoadFeedResult<Error>) -> Void)
}
