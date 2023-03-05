//
//  CodableFeedStoreTests.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Kai Chi Tsao on 2023/3/5.
//

import XCTest
import EssentialFeed_KaiLearning

class CodableFeedStore{
    
    private struct Cache:Codable{
        let feed:[LocalFeedImage]
        let timestamp:Date
    }
    
    private let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appending(path: "image-feed.store")
    
    func retrieve(completion:@escaping FeedStore.RetrievalCompletion){
        guard let data = try? Data(contentsOf: storeURL) else{
           return completion(.empty)
        }
        
        let decoder = JSONDecoder()
        let cache = try! decoder.decode(Cache.self, from: data)
        completion(.found(feed: cache.feed, timestamp: cache.timestamp))
    }
    
    func insert(_ feed:[LocalFeedImage],timestamp:Date,completion:@escaping FeedStore.InsertionCompletion){
        
        let encoder = JSONEncoder()
        let encoded = try! encoder.encode(Cache(feed: feed, timestamp: timestamp))
        try! encoded.write(to: storeURL)
        completion(nil)
    }
    
}


class CodableFeedStoreTests:XCTestCase{
    
    override func setUp() {
        super.setUp()
        let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appending(path: "image-feed.store")
        try? FileManager.default.removeItem(at: storeURL)
    }
    
    func test_retrieve_deliversEmptyOnEmptyCache(){
        let sut = CodableFeedStore()
        let exp = expectation(description: "Wait for cache retrival")
        
        sut.retrieve { result in
            switch result {
            case .empty:
                break
            default:
                XCTFail("Expected empty result,got \(result) instead")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_retrieve_hsaNoSideEffectsOnEmptyCache(){
        let sut = CodableFeedStore()
        let exp = expectation(description: "Wait for cache retrival")
        
        sut.retrieve { firstReult in
            sut.retrieve { secondResult in
                switch (firstReult,secondResult) {
                case (.empty,.empty):
                    break
                default:
                    XCTFail("Expected retrieving twice from empty cache to deliver same empty result,got \(firstReult) and \(secondResult) instead")
                }
                exp.fulfill()
            }
        }
        
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_retrieveAfterInsertingToEmptyCache_deliversInsertedValues(){
        let sut = CodableFeedStore()
        let feed = uniqueImageFeed().local
        let timestamp = Date()
        let exp = expectation(description: "Wait for cache retrival")
        
        sut.insert(feed, timestamp: timestamp) { insertionError in
            
            XCTAssertNil(insertionError,"Expected feed to be inserted successfully")
            
            sut.retrieve { retrieveResult in
                switch retrieveResult{
                case let .found(retrievedFeed, retrievedTimestamp):
                    XCTAssertEqual(retrievedFeed, feed)
                    XCTAssertEqual(retrievedTimestamp, timestamp)
                default:
                    XCTFail("Expected found result with feed \(feed) and timestsamp \(timestamp),got \(retrieveResult) instead")
                }
                exp.fulfill()
            }
        }
        
        
        wait(for: [exp], timeout: 1.0)
    }
    
}
