//
//  URLSessionHTTPClientTests.swift
//  EssentialFeed-KaiLearningTests
//
//  Created by Kai Chi Tsao on 2023/2/4.
//

import XCTest
import EssentialFeed_KaiLearning


class URLSessionHTTPClient{
    private let session:URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    struct UnexpectedValueRepresentation:Error{}
    
    func get(from url:URL,completion:@escaping (HTTPClientResult) -> Void){
        session.dataTask(with: url) { _,_,error in
            if let error = error {
                completion(.failure(error))
            }else {
                completion(.failure(UnexpectedValueRepresentation()))
            }
        }.resume()
    }
    
}

class URLSessionHTTPClientTests:XCTestCase{
    
    override func setUp(){
        super.setUp()
        
        URLProtocolStub.startInterceptingRequests()
    }
    
    override func tearDown() {
        super.tearDown()
        
        URLProtocolStub.stopInterceptingRequests()
    }

    func test_getFromURL_performsGETRequestWithURL(){
        let url = anyURL()
        let exp = expectation(description: "Wait for request")
        URLProtocolStub.observerRequests{ request in
            XCTAssertEqual(request.url,url)
            XCTAssertEqual(request.httpMethod,"GET")
            exp.fulfill()
        }
        makeSut().get(from: url) { _ in }
        wait(for: [exp], timeout: 1.0)
    }
    
    
    func test_getFromURL_failsOnRequestError(){
        let requestError = NSError(domain: "any error", code: 1)
        let receivedError = resultErrorFor(data: nil, response: nil, error: requestError)
        XCTAssertNotNil(receivedError)
    }
    
    
    func test_getFromURL_failsOnAllInvalidRepresentationCase(){
        
//        XCTAssertNotNil(resultErrorFor(data: nil, response: nil, error: nil))
//        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse, error: nil))
//        XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPURLResponse, error: nil))
//        XCTAssertNotNil(resultErrorFor(data: anyData, response: nil, error: nil))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse(), error: anyNSError()))
        XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPURLResponse(), error: anyNSError()))
        XCTAssertNotNil(resultErrorFor(data: anyData(), response: nonHTTPURLResponse(), error: anyNSError()))
        XCTAssertNotNil(resultErrorFor(data: anyData(), response: anyHTTPURLResponse(), error: anyNSError()))
//        XCTAssertNotNil(resultErrorFor(data: anyData, response: nonHTTPURLResponse, error: nil))
    }
    
    func test_getFromURL_succedsOnHTTPURLResponseWithData(){
        let data = anyData()
        let response = anyHTTPURLResponse()
        URLProtocolStub.stub(data: data, response: response, error: nil)
    }
    
    // MARK: - Helpers
    
    private func makeSut(file:StaticString = #filePath,line:UInt = #line) -> URLSessionHTTPClient{
        let sut = URLSessionHTTPClient()
        trackForMemoryLeaks(sut, file: file,line: line)
        return sut
    }
    
    private func resultErrorFor(data:Data?,response:URLResponse?,error:Error?,file:StaticString = #filePath,line:UInt = #line) -> Error?{
        
        URLProtocolStub.stub(data:data,response:response,error:error)
        let sut = makeSut(file: file,line: line)
        let exp = expectation(description: "wait for completion")
        
        var receivedError:Error?
        
        sut.get(from:anyURL()){ result in
            switch result {
            case let .failure(error):
                receivedError = error
            default:
                XCTFail("Expected failure ,got \(result) instead",file: file,line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        return receivedError
    }
    
    private func anyURL() -> URL{
        return URL(string: "http://any-url.com")!
    }
    
    private func anyData() -> Data{
        return Data("any error".utf8)
    }
    
    private func anyNSError() -> NSError{
        return NSError(domain: "any error", code: 0)
    }
    
    private func anyHTTPURLResponse() -> HTTPURLResponse{
        return HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
    
    private func nonHTTPURLResponse() -> URLResponse{
        return URLResponse(url:anyURL(),mimeType: nil,expectedContentLength: 0,textEncodingName: nil)
    }
    
    private class URLProtocolStub:URLProtocol{
   
        private static var stub: Stub?
        private static var requestObserver:((URLRequest) -> Void)?
        private struct Stub{
            let data:Data?
            let response:URLResponse?
            let error:Error?
        }
        
        static func stub(data:Data?,response:URLResponse?,error:Error?){
            stub = Stub(data: data, response: response, error: error)
        }
        
        static func observerRequests(observer: @escaping (URLRequest) -> Void){
            requestObserver = observer
        }
        
        static func startInterceptingRequests(){
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequests(){
            URLProtocol.unregisterClass(URLProtocolStub.self)
            requestObserver = nil
            stub = nil
        }
        
        override class func canInit(with request: URLRequest) -> Bool {
            requestObserver?(request)
            return true
        }
        
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
            
            if let data = URLProtocolStub.stub?.data{
                client?.urlProtocol(self,didLoad: data)
            }
            
            if let response = URLProtocolStub.stub?.response{
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let error = URLProtocolStub.stub?.error{
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
        
        override func stopLoading() {
            
        }
    }

}


