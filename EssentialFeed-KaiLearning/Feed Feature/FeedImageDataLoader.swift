//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Kai Chi Tsao on 2023/3/12.
//

import Foundation


public protocol FeedImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
