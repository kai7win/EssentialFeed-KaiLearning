//
//  FeedItem.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/1.
//

import Foundation

public struct FeedImage: Hashable {
    public let id:UUID
    public let description:String?
    public let location:String?
    public let url:URL
    
    public init(id: UUID, description: String?, location: String?, url: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = url
    }
}

