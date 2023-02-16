//
//  FeedStore.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/15.
//

import Foundation

public protocol FeedStore{
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (Error?) -> Void
    
    func deleteCachedFeed(comletion:@escaping DeletionCompletion)
    func insert(_ items:[LocalFeedImage],timestamp:Date,completion:@escaping InsertionCompletion)
    func retrieve(completion:@escaping RetrievalCompletion)
}



