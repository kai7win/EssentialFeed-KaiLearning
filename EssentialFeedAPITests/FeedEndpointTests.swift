//
//  FeedEndpointTests.swift
//  EssentialFeedAPITests
//
//  Created by Kai Chi Tsao on 2023/5/22.
//

import XCTest
import EssentialFeed_KaiLearning
import EssentialFeedAPI

class FeedEndpointTests: XCTestCase {

    func test_feed_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!

        let received = FeedEndpoint.get.url(baseURL: baseURL)
        let expected = URL(string: "http://base-url.com/v1/feed")!

        XCTAssertEqual(received, expected)
    }

}
