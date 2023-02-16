//
//  LocalFeedLoader.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/15.
//

import Foundation


public final class LocalFeedLoader{
    
    private let store:FeedStore
    private let currentDate: () -> Date
    
    public typealias SaveResult = Error?
    
    public init(store:FeedStore,currentDate:@escaping () -> Date){
        self.store = store
        self.currentDate = currentDate
    }
    
    public func save(_ items:[FeedImage],completion: @escaping (Error?) -> Void){
        store.deleteCachedFeed{ [weak self] error in
            guard let self = self else { return }
            if let cacheDeletionError = error{
                completion(cacheDeletionError)
            }else{
                self.cache(items,with:completion)
            }
        }
    }
    
    private func cache(_ items:[FeedImage],with completion:@escaping (Error?) -> Void){
        store.insert(items.toLocal(), timestamp: self.currentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
    
    public func load(){
        store.retrieve()
    }
}


private extension Array where Element == FeedImage{
    func toLocal() -> [LocalFeedImage]{
        return map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
    }
    
}
