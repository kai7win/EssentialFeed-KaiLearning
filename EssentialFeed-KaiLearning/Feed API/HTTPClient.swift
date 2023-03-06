//
//  HTTPClient.swift
//  EssentialFeed-KaiLearning
//
//  Created by Kai Chi Tsao on 2023/2/4.
//

import Foundation

public enum HTTPClientResult{
    case success(Data,HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient{
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    ///完成處理程序可以在任何線程中被調用。 如果需要，客戶端負責調度到適當的線程。
    func get(from url:URL,completion:@escaping (HTTPClientResult) -> Void)
}
