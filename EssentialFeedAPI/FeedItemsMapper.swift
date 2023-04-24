//
//  FeedItemsMapper.swift
//  EssentialFeed-KaiLearning
//
//  Created by Kai Chi Tsao on 2023/2/4.
//

import Foundation
import EssentialFeed_KaiLearning

final class FeedItemsMapper{
    
    private struct Root:Decodable{
        private let items: [RemoteFeedItem]
        
        private struct RemoteFeedItem: Decodable {
            let id: UUID
            let description: String?
            let location: String?
            let image: URL
        }
        
        var images: [FeedImage] {
            items.map { FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.image) }
        }
    }
    
    private static var OK_200:Int { return 200 }
    
    static func map(_ data:Data,from response:HTTPURLResponse) throws -> [FeedImage]{
        
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        return root.images
        
    }
    
}