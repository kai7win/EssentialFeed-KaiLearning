//
//  CacheFeedUseCaseTests.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Kai Chi Tsao on 2023/2/11.
//

import XCTest
import EssentialFeed_KaiLearning

class LocalFeedLoader{
    
    private let store:FeedStore
    private let currentDate: () -> Date
    
    init(store:FeedStore,currentDate:@escaping () -> Date){
        self.store = store
        self.currentDate = currentDate
    }
    
    func save(_ items:[FeedItem]){
        store.deleteCachedFeed{ [unowned self] error in
            if error == nil {
                self.store.insert(items, timestamp: self.currentDate())
            }
        }
    }
}
 

class FeedStore{
    typealias DeletionCompletion = (Error?) -> Void
    
    enum ReceivedMessage:Equatable{
        case deleteCachedFeed
        case insert([FeedItem],Date)
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var deletionCompletions = [DeletionCompletion]()
    
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
    
    func insert(_ items:[FeedItem],timestamp:Date){
        receivedMessages.append(.insert(items, timestamp))
    }
    
}

final class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotMessageStoreUponCreation(){
        let (_,store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_save_requestsCacheDeletion(){
        let (sut,store) = makeSUT()
        let items = [uniqueItem(),uniqueItem()]
        
        sut.save(items)
        
        XCTAssertEqual(store.receivedMessages, [.deleteCachedFeed])
    }
    
    func test_save_doesNotRequestCacheInsertionOnDeletionError(){
        
        let items = [uniqueItem(),uniqueItem()]
        let (sut,store) = makeSUT()
        let deletionError = anyNSError()
        
        sut.save(items)
        store.completeDeletion(with:deletionError)
        
        XCTAssertEqual(store.receivedMessages, [.deleteCachedFeed])
    }
    
    
    func test_save_requestsNewCacheInsertionWithTimestampOnSuccessfulDeletion(){
        let timestamp = Date()
        let items = [uniqueItem(),uniqueItem()]
        let (sut,store) = makeSUT(currentDate:{ timestamp })

        
        sut.save(items)
        store.completeDeletionSuccessfully()
        
        XCTAssertEqual(store.receivedMessages, [.deleteCachedFeed,.insert(items, timestamp)])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(currentDate:@escaping () -> Date = Date.init,file:StaticString = #filePath,line:UInt = #line) -> (sut:LocalFeedLoader,store:FeedStore){
        let store = FeedStore()
        let sut = LocalFeedLoader(store:store,currentDate:currentDate)
        trackForMemoryLeaks(store,file: file,line: line)
        trackForMemoryLeaks(sut,file: file,line: line)
        return (sut,store)
    }
    
    private func uniqueItem() -> FeedItem{
        
        return FeedItem(id: UUID(), description: "any", location: "any", imageURL: anyURL())
    }
    
    private func anyURL() -> URL{
        return URL(string: "http://any-url.com")!
    }

    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
    
}
