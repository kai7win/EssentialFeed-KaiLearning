//
//  RemoteImageCommentsLoader.swift
//  EssentialFeedAPI
//
//  Created by Kai Chi Tsao on 2023/4/24.
//


import Foundation
import EssentialFeed_KaiLearning


public typealias RemoteImageCommentsLoader = RemoteLoader<[ImageComment]>

public extension RemoteImageCommentsLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: ImageCommentsMapper.map)
    }
}
