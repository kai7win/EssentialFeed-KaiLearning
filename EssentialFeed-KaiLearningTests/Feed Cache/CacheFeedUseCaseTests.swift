//
//  CacheFeedUseCaseTests.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Kai Chi Tsao on 2023/2/11.
//

import XCTest

class LocalFeedLoader{
    init(store:FeedStore){
        
    }
}


class FeedStore{
    var deleteCachedFeedCallCount = 0
}

final class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation(){
        let store = FeedStore()
        let _ = LocalFeedLoader(store:store)
        
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }

}
