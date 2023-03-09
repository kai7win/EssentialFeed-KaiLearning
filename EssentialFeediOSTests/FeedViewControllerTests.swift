//
//  FeedViewControllerTests.swift
//  EssentialFeediOSTests
//
//  Created by 湯瑪士 on 2023/3/9.
//

import XCTest

final class FeedViewController{
    
    init(loader:FeedViewControllerTests.LoaderSpy){
        
    }
    
}

final class FeedViewControllerTests:XCTestCase{
    
    func test_init_doesNotLoadFeed(){
        let loader = LoaderSpy()
        _ = FeedViewController(loader:loader)
        XCTAssertEqual(loader.loadCallCount, 0)
    }

    // MARK: - Helpers
    
    class LoaderSpy{
        private(set) var loadCallCount:Int = 0
        
    }
    
}
