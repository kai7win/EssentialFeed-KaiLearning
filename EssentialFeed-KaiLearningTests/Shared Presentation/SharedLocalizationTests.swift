//
//  SharedLocalizationTests.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Kai Chi Tsao on 2023/5/3.
//

import XCTest
import EssentialFeed_KaiLearning

class SharedLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Shared"
        let bundle = Bundle(for: LoadResourcePresenter<Any, DummyView>.self)
        assertLocalizedKeyAndValuesExist(in: bundle, table)
        
    }

    private class DummyView: ResourceView {
        func display(_ viewModel: Any) {}
    }

}
