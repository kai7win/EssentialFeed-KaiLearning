//
//  FeedCacheTestHelpers.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Kai Chi Tsao on 2023/3/4.
//

import Foundation
import EssentialFeed_KaiLearning

func uniqueImage() -> FeedImage{
    return FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())
}

func uniqueImageFeed() -> (models:[FeedImage],local:[LocalFeedImage]){
    let models = [uniqueImage(),uniqueImage()]
    let local = models.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
    return (models,local)
}


extension Date{
    
    func minusFeedCacheMaxAge() -> Date{
        return adding(days: -7)
    }
    
    func adding(days:Int) -> Date{
        return Calendar(identifier: .gregorian).date(byAdding: .day,value: days, to: self)!
    }
    
    func adding(seconds:TimeInterval) -> Date{
        return self + seconds
    }
}