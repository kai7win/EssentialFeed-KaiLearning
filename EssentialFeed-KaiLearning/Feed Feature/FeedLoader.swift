//
//  FeedLoader.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/1.
//

import Foundation

public protocol FeedLoader{
    
    typealias Result = Swift.Result<[FeedImage], Error>
    
    func load(completion:@escaping (Result) -> Void)
    
}
