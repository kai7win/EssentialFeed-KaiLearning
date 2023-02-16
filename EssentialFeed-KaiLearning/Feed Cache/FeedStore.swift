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
    
    func deleteCachedFeed(comletion:@escaping DeletionCompletion)
    func insert(_ items:[LocalFeedItem],timestamp:Date,completion:@escaping InsertionCompletion)
}



