//
//  FeedStore.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/15.
//

import Foundation

public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore{
    
    typealias DeletionResult = Result<Void, Error>
    typealias DeletionCompletion = (DeletionResult) -> Void
    
    typealias InsertionResult = Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void
    
    typealias RetrievalResult = Result<CachedFeed?, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void
    
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



