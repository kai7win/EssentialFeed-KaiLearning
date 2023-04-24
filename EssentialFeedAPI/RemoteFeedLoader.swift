//
//  RemoteFeedLoader.swift
//  EssentialFeed-KaiLearning
//
//  Created by Thomas on 2023/2/1.
//

import Foundation
import EssentialFeed_KaiLearning

public final class RemoteFeedLoader:FeedLoader{
    private let url:URL
    private let client:HTTPClient
    
    public enum Error:Swift.Error{
        case connectivity
        case invalidData
    }
    
    public typealias Result = FeedLoader.Result
  
    
    public init(url:URL,client:HTTPClient){
        self.url = url
        self.client = client
    }
    
    public func load(completion:@escaping (Result) -> Void){
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result{
            case let .success((data,response)):
                completion(RemoteFeedLoader.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data:Data,from response:HTTPURLResponse) -> Result{
        do{
            let items = try FeedItemsMapper.map(data, from: response)
            return .success(items)
        }catch{
            return .failure(error)
        }
    
    }
    
}



