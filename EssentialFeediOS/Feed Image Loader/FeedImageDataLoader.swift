//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Kai Chi Tsao on 2023/3/12.
//

import Foundation

public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    
    typealias Result = Swift.Result<Data, Error>
    
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
