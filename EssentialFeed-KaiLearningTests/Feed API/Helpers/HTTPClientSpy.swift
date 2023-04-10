//
//  HTTPClientSpy.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Kai Chi Tsao on 2023/4/11.
//

import Foundation
import EssentialFeed_KaiLearning

class HTTPClientSpy: HTTPClient {
    private struct Task: HTTPClientTask {
        let callback: () -> Void
        func cancel() { callback() }
    }

    private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()
    private(set) var cancelledURLs = [URL]()

    var requestedURLs: [URL] {
        return messages.map { $0.url }
    }

    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        messages.append((url, completion))
        return Task { [weak self] in
            self?.cancelledURLs.append(url)
        }
    }

    func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }

    func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
        let response = HTTPURLResponse(
            url: requestedURLs[index],
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        messages[index].completion(.success((data, response)))
    }
}
