//
//  ResourceErrorViewModel.swift
//  EssentialFeed-KaiLearning
//
//  Created by Kai Chi Tsao on 2023/5/3.
//

public struct ResourceErrorViewModel {
    public let message: String?

    static var noError: ResourceErrorViewModel {
        return ResourceErrorViewModel(message: nil)
    }

    static func error(message: String) -> ResourceErrorViewModel {
        return ResourceErrorViewModel(message: message)
    }
}
