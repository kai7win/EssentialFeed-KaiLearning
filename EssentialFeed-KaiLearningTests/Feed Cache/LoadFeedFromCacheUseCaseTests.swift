//
//  LoadFeedFromCacheUseCaseTests.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Thomas on 2023/2/16.
//

import XCTest
import EssentialFeed_KaiLearning

class LoadFeedFromCacheUseCaseTests:XCTestCase{
    
    
    func test_init_doesNotMessageStoreUponCreation(){
        let (_,store) = makeSUT()
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_load_requestsCacheRetrieval(){
        let (sut,store) = makeSUT()
        sut.load { _ in }
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_failsOnRetrivalError(){
        let (sut,store) = makeSUT()
        let retrievalError = anyNSError()
        
        expect(sut, toCompleteWith: .failure(retrievalError)) {
            store.completeRetrival(with:retrievalError)
        }
       
    }
    
    func test_load_deliversNoImagesOnEmptyCache(){
        let (sut,store) = makeSUT()
        expect(sut, toCompleteWith: .success([])) {
            store.completeRetrivalWithEmptyCache()
        }
    }
    
    func test_load_deliversCachedImagesOnNonExpiredCache(){
        let feed = uniqueImageFeed()
        let fixCurrentDate = Date()
        let nonExpiredTimestamp = fixCurrentDate.minusFeedCacheMaxAge().adding(seconds: 1)
        
        let (sut,store) = makeSUT {
            fixCurrentDate
        }
        expect(sut, toCompleteWith: .success(feed.models)) {
            store.completeRetrival(with: feed.local,timestamp:nonExpiredTimestamp)
        }
    }
    
    func test_load_deliversNoImagesOnCacheExpiration(){
        let feed = uniqueImageFeed()
        let fixCurrentDate = Date()
        let expirationTimestamp = fixCurrentDate.minusFeedCacheMaxAge()
        
        let (sut,store) = makeSUT {
            fixCurrentDate
        }
        expect(sut, toCompleteWith: .success([])) {
            store.completeRetrival(with: feed.local,timestamp:expirationTimestamp)
        }
    }
    
    func test_load_deliversNoImagesOnExpiredCache(){
        let feed = uniqueImageFeed()
        let fixCurrentDate = Date()
        let expiredimestamp = fixCurrentDate.minusFeedCacheMaxAge().adding(seconds: -1)
        
        let (sut,store) = makeSUT {
            fixCurrentDate
        }
        expect(sut, toCompleteWith: .success([])) {
            store.completeRetrival(with: feed.local,timestamp:expiredimestamp)
        }
    }
    
    func test_load_hasNoSideEffectsOnRetrievalError(){
        let (sut,store) = makeSUT()
        sut.load { _ in }
        store.completeRetrival(with: anyNSError())
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_hasNoSideEffectsOnEmptyCache(){
        let (sut,store) = makeSUT()
        sut.load { _ in }
        store.completeRetrivalWithEmptyCache()
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    
    func test_load_hasNoSideEffectsOnNonExpiredCacheCache(){
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let nonExpiredTimestamp = fixedCurrentDate.minusFeedCacheMaxAge().adding(seconds: 1)
        
        let (sut,store) = makeSUT(currentDate: { fixedCurrentDate })
        sut.load { _ in }
        store.completeRetrival(with: feed.local,timestamp: nonExpiredTimestamp)
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_hasNoSideEffectsOnCacheExpiration(){
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let expirationTimestamp = fixedCurrentDate.minusFeedCacheMaxAge()
        
        let (sut,store) = makeSUT(currentDate: { fixedCurrentDate })
        sut.load { _ in }
        store.completeRetrival(with: feed.local,timestamp: expirationTimestamp)
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_hasNoSideEffectsOnExpiredCache(){
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let expiredTimestamp = fixedCurrentDate.minusFeedCacheMaxAge().adding(seconds: -1)
        
        let (sut,store) = makeSUT(currentDate: { fixedCurrentDate })
        sut.load { _ in }
        store.completeRetrival(with: feed.local,timestamp: expiredTimestamp)
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated(){
        let store = FeedStoreSpy()
        var sut: LocalFeedLoader? = LocalFeedLoader(store: store, currentDate: Date.init)
        
        var receivedResult = [LocalFeedLoader.LoadResult]()
        sut?.load { receivedResult.append($0) }
        
        sut = nil
        store.completeRetrivalWithEmptyCache()
        
        XCTAssertTrue(receivedResult.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(currentDate:@escaping () -> Date = Date.init,file:StaticString = #filePath,line:UInt = #line) -> (sut:LocalFeedLoader,store:FeedStoreSpy){
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store:store,currentDate:currentDate)
        trackForMemoryLeaks(store,file: file,line: line)
        trackForMemoryLeaks(sut,file: file,line: line)
        return (sut,store)
    }
    
    private func expect(_ sut:LocalFeedLoader,toCompleteWith expectedResult: LocalFeedLoader.LoadResult,when action:()->Void,file:StaticString = #filePath,line:UInt = #line){
        
        let exp = expectation(description: "Wait for load completion")


        sut.load { receivedResult in
            switch (receivedResult,expectedResult){
            case let (.success(receivedImages),.success(expectedImages)):
               XCTAssertEqual(receivedImages, expectedImages,file: file,line: line)
                
            case let (.failure(receivedError as NSError),.failure(expectedError as NSError)):
               XCTAssertEqual(receivedError, expectedError,file: file,line: line)
                
            default:
                XCTFail("Expected result \(expectedResult),got \(receivedResult) instead",file: file,line: line)
            }
            
            exp.fulfill()
        }

        action()

        wait(for: [exp], timeout: 1.0)
        
    }

}



