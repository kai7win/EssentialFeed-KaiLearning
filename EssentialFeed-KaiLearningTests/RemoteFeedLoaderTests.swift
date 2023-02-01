//
//  RemoteFeedLoaderTests.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Thomas on 2023/2/1.
//

import XCTest

class RemoteFeedLoader{
    
}

class HTTPClient{
    var requestedURL:URL?
}

class RemoteFeedLoaderTests:XCTest{
    
    func test_init_doesNotRequestDataFromURL(){
        let client = HTTPClient()
        let sut = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
}
