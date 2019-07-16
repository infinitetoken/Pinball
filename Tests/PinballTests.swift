//
//  PinballTests.swift
//  Pinball
//
//  Created by Aaron Wright on 7/16/19.
//  Copyright © 2019 Infinite Token LLC. All rights reserved.
//

import XCTest
@testable import Pinball

final class PinballTests: XCTestCase {
    
    let paths: [String] = ["widgets"]
    let queries: [Pinball.Query] = [
        Pinball.Query(key: "foo", value: "bar")
    ]
    let headers: [Pinball.Header] = [
        Pinball.Header.accept("application/json"),
        Pinball.Header.contentType("application/json")
    ]
    
    func testCanBuildURLComponents() {
        var endpoint = Pinball.Endpoint(method: .get, scheme: .https, host: "localhost", port: 3000, user: "example", password: "password", paths: paths, queries: queries, headers: headers, data: nil)
        var urlComponents = endpoint.urlComponents
        
        XCTAssertNotNil(urlComponents)
        XCTAssertEqual(urlComponents.scheme, "https")
        XCTAssertEqual(urlComponents.host, "localhost")
        XCTAssertEqual(urlComponents.port, 3000)
        XCTAssertEqual(urlComponents.user, "example")
        XCTAssertEqual(urlComponents.password, "password")
        XCTAssertEqual(urlComponents.path, "/widgets")
        XCTAssertEqual(urlComponents.queryItems?.count, 1)
        XCTAssertEqual(urlComponents.queryItems?.first, URLQueryItem(name: "foo", value: "bar"))
        
        endpoint.port = 80
        endpoint.paths = []
        endpoint.queries = []
        
        urlComponents = endpoint.urlComponents
        
        XCTAssertNil(urlComponents.port)
        XCTAssertEqual(urlComponents.path, "")
        XCTAssertNil(urlComponents.queryItems)
    }
    
    func testCanBuildURL() {
        let endpoint = Pinball.Endpoint(method: .get, scheme: .https, host: "localhost", port: 3000, user: "example", password: "password", paths: paths, queries: queries, headers: headers, data: nil)
        
        XCTAssertNoThrow(try endpoint.url())
    }
    
    func testCanBuildURLRequest() {
        let endpoint = Pinball.Endpoint(method: .get, scheme: .https, host: "localhost", port: 3000, user: "example", password: "password", paths: paths, queries: queries, headers: headers, data: nil)
        
        XCTAssertNoThrow(try endpoint.urlRequest(allowsCellularAccess: true, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData))
    }
    
    func testCanDescribe() {
        let endpoint = Pinball.Endpoint(method: .get, scheme: .https, host: "localhost", port: 3000, user: "example", password: "password", paths: paths, queries: queries, headers: headers, data: nil)
        
        XCTAssertNotNil(endpoint.description)
        XCTAssertNotNil(endpoint.debugDescription)
    }
    
    func testCanDescribeError() {
        let error = Pinball.Error.urlError
        
        XCTAssertEqual(error.localizedDescription, "URL could not be formed")
    }
    
    func testCanConvertHeaderToData() {
        headers.forEach { (header) in
            let data = header.data
            
            switch header {
            case .accept(let value):
                XCTAssertEqual(data.key, "Accept")
                XCTAssertEqual(data.value, value)
            case .contentType(let value):
                XCTAssertEqual(data.key, "Content-Type")
                XCTAssertEqual(data.value, value)
            }
        }
    }
    
    func testCanBuildURLSessionTasks() {
        let endpoint = Pinball.Endpoint(method: .get, scheme: .https, host: "localhost", port: 3000, user: "example", password: "password", paths: paths, queries: queries, headers: headers, data: nil)
        
        do {
            let _ = try URLSession.shared.dataTask(for: endpoint)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        do {
            let _ = try URLSession.shared.dataTask(for: endpoint, completionHandler: { (_, _, _) in })
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func testCanBuildURLSessionPublisher() {
        let endpoint = Pinball.Endpoint(method: .get, scheme: .https, host: "localhost", port: 3000, user: "example", password: "password", paths: paths, queries: queries, headers: headers, data: nil)
        
        do {
            let _ = try URLSession.shared.dataTaskPublisher(for: endpoint)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}
