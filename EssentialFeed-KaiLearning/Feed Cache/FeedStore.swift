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
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    ///完成處理程序可以在任何線程中被調用。 如果需要，客戶端負責調度到適當的線程。
    func deleteCachedFeed(completion:@escaping DeletionCompletion)
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    ///完成處理程序可以在任何線程中被調用。 如果需要，客戶端負責調度到適當的線程。
    func insert(_ items:[LocalFeedImage],timestamp:Date,completion:@escaping InsertionCompletion)
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    /// 完成處理程序可以在任何線程中被調用。 如果需要，客戶端負責調度到適當的線程。
    func retrieve(completion:@escaping RetrievalCompletion)
}



