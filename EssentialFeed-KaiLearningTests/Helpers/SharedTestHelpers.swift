//
//  SharedTestHelpers.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Kai Chi Tsao on 2023/3/4.
//

import Foundation


func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL{
    return URL(string: "http://any-url.com")!
}
