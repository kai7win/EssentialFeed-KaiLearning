//
//  ImageCommentsLocalizationTests.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Kai Chi Tsao on 2023/5/7.
//

import XCTest
import EssentialFeed_KaiLearning

class ImageCommentsLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "ImageComments"
        let bundle = Bundle(for: ImageCommentsPresenter.self)

        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }

}
