//
//  FeedImageViewModel.swift
//  EssentialFeed-KaiLearning
//
//  Created by Kai Chi Tsao on 2023/4/9.
//

public struct FeedImageViewModel<Image> {
    public let description: String?
    public let location: String?
    public let image: Image?
    public let isLoading: Bool
    public let shouldRetry: Bool

    public var hasLocation: Bool {
        return location != nil
    }
}
