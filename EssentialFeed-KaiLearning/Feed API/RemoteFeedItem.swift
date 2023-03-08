//
//  RemoteFeedItem.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/16.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id:UUID
    let description:String?
    let location:String?
    let image:URL
}
