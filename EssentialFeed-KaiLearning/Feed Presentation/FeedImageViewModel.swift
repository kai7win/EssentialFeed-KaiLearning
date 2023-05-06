//
//  FeedImageViewModel.swift
//  EssentialFeed-KaiLearning
//
//  Created by Kai Chi Tsao on 2023/4/9.
//

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?
    
    public var hasLocation: Bool {
        return location != nil
    }
}
