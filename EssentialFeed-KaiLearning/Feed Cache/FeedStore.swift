//
//  FeedStore.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/15.
//

import Foundation

public enum RetrieveCachedFeedResult{
    case empty
    case found(feed:[LocalFeedImage],timestamp:Date)
    case failure(Error)
}

public protocol FeedStore{
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrieveCachedFeedResult) -> Void
    
    func deleteCachedFeed(comletion:@escaping DeletionCompletion)
    func insert(_ items:[LocalFeedImage],timestamp:Date,completion:@escaping InsertionCompletion)
    func retrieve(completion:@escaping RetrievalCompletion)
}



