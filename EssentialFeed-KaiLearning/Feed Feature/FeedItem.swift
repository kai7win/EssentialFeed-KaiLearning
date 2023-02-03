//
//  FeedItem.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/1.
//

import Foundation

public struct FeedItem: Equatable {
    public let id:UUID
    public let description:String?
    public let location:String?
    public let imageURL:URL
    
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}

