//
//  CodableFeedStoreTests.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Kai Chi Tsao on 2023/3/5.
//

import XCTest
import EssentialFeed_KaiLearning

class CodableFeedStore{
    
    func retrieve(completion:@escaping FeedStore.RetrievalCompletion){
        completion(.empty)
    }
    
}


class CodableFeedStoreTests:XCTestCase{
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
    
}
