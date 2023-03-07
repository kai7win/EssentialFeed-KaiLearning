//
//  XCTestCase+FailableRetrieveFeedStoreSpecs.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by 湯瑪士 on 2023/3/7.
//

import XCTest
import EssentialFeed_KaiLearning

extension FailableRetrieveFeedStoreSpecs where Self: XCTestCase {
    func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: .failure(anyNSError()), file: file, line: line)
    }

    func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .failure(anyNSError()), file: file, line: line)
    }
}

