//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Kai Chi Tsao on 2023/2/5.
//

import XCTest

extension XCTestCase{
    func trackForMemoryLeaks(_ instance:AnyObject,file:StaticString = #filePath,line:UInt = #line){
        
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance shoud have been deallocated. Potential memory leak.",file: file,line: line)
        }
    }
}
