//
//  FeedLocalizationTests.swift
//  EssentialFeediOSTests
//
//  Created by Kai Chi Tsao on 2023/4/8.
//

import XCTest
import EssentialFeed_KaiLearning

final class FeedLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }

   
}
