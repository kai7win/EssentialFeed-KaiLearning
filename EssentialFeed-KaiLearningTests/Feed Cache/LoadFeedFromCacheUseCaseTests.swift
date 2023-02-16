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
        let exp = expectation(description: "Wait for load completion")
        
        var receivedError:Error?
        
        sut.load { error in
            receivedError = error
            exp.fulfill()
        }
        
        store.completeRetrival(with:retrievalError)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError as NSError?, retrievalError)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(currentDate:@escaping () -> Date = Date.init,file:StaticString = #filePath,line:UInt = #line) -> (sut:LocalFeedLoader,store:FeedStoreSpy){
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store:store,currentDate:currentDate)
        trackForMemoryLeaks(store,file: file,line: line)
        trackForMemoryLeaks(sut,file: file,line: line)
        return (sut,store)
    }
    
    
    private func anyURL() -> URL{
        return URL(string: "http://any-url.com")!
    }

    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
    
    
    
}
