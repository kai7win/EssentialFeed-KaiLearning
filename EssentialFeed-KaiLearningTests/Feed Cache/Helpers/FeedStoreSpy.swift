//
//  FeedStoreSpy.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Thomas on 2023/2/16.
//

import Foundation
import EssentialFeed_KaiLearning

class FeedStoreSpy:FeedStore{
    
    enum ReceivedMessage:Equatable{
        case deleteCachedFeed
        case insert([LocalFeedImage],Date)
        case retrieve
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var deletionCompletions = [DeletionCompletion]()
    private var insertionCompletions = [InsertionCompletion]()
    private var retrievalCompletions = [RetrievalCompletion]()
    
    func deleteCachedFeed(comletion:@escaping DeletionCompletion){
        deletionCompletions.append(comletion)
        receivedMessages.append(.deleteCachedFeed)
    }
    
    func completeDeletion(with error:Error,at index:Int = 0){
        deletionCompletions[index](error)
    }
    
    func completeDeletionSuccessfully(at index: Int = 0){
        deletionCompletions[index](nil)
    }
    
    func insert(_ items:[LocalFeedImage],timestamp:Date,completion:@escaping InsertionCompletion){
        insertionCompletions.append(completion)
        receivedMessages.append(.insert(items, timestamp))
    }
    
    func completeInsertion(with error:Error,at index:Int = 0){
        insertionCompletions[index](error)
    }
    
    func completeInsertionSuccessfully(at index: Int = 0){
        insertionCompletions[index](nil)
    }
    
    func retrieve(completion:@escaping RetrievalCompletion) {
        retrievalCompletions.append(completion)
        receivedMessages.append(.retrieve)
    }
    
    func completeRetrival(with error: Error,at index:Int = 0) {
        retrievalCompletions[index](error)
    }
    
    func completeRetrivalWithEmptyCache(at index:Int = 0){
        retrievalCompletions[index](nil)
    }
}
