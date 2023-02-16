//
//  RemoteFeedItem.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/16.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id:UUID
    internal let description:String?
    internal let location:String?
    internal let image:URL
}
