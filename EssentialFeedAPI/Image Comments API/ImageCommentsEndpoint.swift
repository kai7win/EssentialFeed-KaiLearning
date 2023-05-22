//
//  ImageCommentsEndpoint.swift
//  EssentialFeedAPI
//
//  Created by Kai Chi Tsao on 2023/5/22.
//

import Foundation

public enum ImageCommentsEndpoint {
    case get(UUID)

    public func url(baseURL: URL) -> URL {
        switch self {
        case let .get(id):
            return baseURL.appendingPathComponent("/v1/image/\(id)/comments")
        }
    }
}
