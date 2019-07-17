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
            case .acceptCharset(let value):
                XCTAssertEqual(data.key, "Accept-Charset")
                XCTAssertEqual(data.value, value)
            case .acceptEncoding(let value):
                XCTAssertEqual(data.key, "Accept-Encoding")
                XCTAssertEqual(data.value, value)
            case .acceptLanguage(let value):
                 XCTAssertEqual(data.key, "Accept-Language")
                XCTAssertEqual(data.value, value)
            case .acceptRanges(let value):
                XCTAssertEqual(data.key, "Accept-Ranges")
                XCTAssertEqual(data.value, value)
            case .age(let value):
                XCTAssertEqual(data.key, "Age")
                XCTAssertEqual(data.value, value)
            case .allow(let value):
                XCTAssertEqual(data.key, "Allow")
                XCTAssertEqual(data.value, value)
            case .authorization(let value):
                 XCTAssertEqual(data.key, "Authorization")
                XCTAssertEqual(data.value, value)
            case .cacheControl(let value):
                XCTAssertEqual(data.key, "Cache-Control")
                XCTAssertEqual(data.value, value)
            case .connection(let value):
                XCTAssertEqual(data.key, "Connection")
                XCTAssertEqual(data.value, value)
            case .contentEncoding(let value):
                XCTAssertEqual(data.key, "Content-Encoding")
                XCTAssertEqual(data.value, value)
            case .contentLanguage(let value):
                XCTAssertEqual(data.key, "Content-Language")
                XCTAssertEqual(data.value, value)
            case .contentLength(let value):
                XCTAssertEqual(data.key, "Content-Length")
                XCTAssertEqual(data.value, value)
            case .contentLocation(let value):
                XCTAssertEqual(data.key, "Content-Location")
                XCTAssertEqual(data.value, value)
            case .contentMD5(let value):
                XCTAssertEqual(data.key, "Content-MD5")
                XCTAssertEqual(data.value, value)
            case .contentRange(let value):
                XCTAssertEqual(data.key, "Content-Range")
                XCTAssertEqual(data.value, value)
            case .contentType(let value):
                XCTAssertEqual(data.key, "Content-Type")
                XCTAssertEqual(data.value, value)
            case .custom(let key, let value):
                XCTAssertEqual(data.key, key)
                XCTAssertEqual(data.value, value)
            case .date(let value):
                XCTAssertEqual(data.key, "Date")
                XCTAssertEqual(data.value, value)
            case .etag(let value):
                XCTAssertEqual(data.key, "ETag")
                XCTAssertEqual(data.value, value)
            case .expect(let value):
                XCTAssertEqual(data.key, "Except")
                XCTAssertEqual(data.value, value)
            case .expires(let value):
                XCTAssertEqual(data.key, "Expires")
                XCTAssertEqual(data.value, value)
            case .from(let value):
                XCTAssertEqual(data.key, "From")
                XCTAssertEqual(data.value, value)
            case .host(let value):
                XCTAssertEqual(data.key, "Host")
                XCTAssertEqual(data.value, value)
            case .ifMatch(let value):
                XCTAssertEqual(data.key, "If-Match")
                XCTAssertEqual(data.value, value)
            case .ifModifiedSince(let value):
                XCTAssertEqual(data.key, "If-Modified-Since")
                XCTAssertEqual(data.value, value)
            case .ifNoneMatch(let value):
                XCTAssertEqual(data.key, "If-None-Match")
                XCTAssertEqual(data.value, value)
            case .ifRange(let value):
                XCTAssertEqual(data.key, "If-Range")
                XCTAssertEqual(data.value, value)
            case .ifUnmodifiedSince(let value):
                XCTAssertEqual(data.key, "If-Unmodified-Since")
                XCTAssertEqual(data.value, value)
            case .lastModified(let value):
                XCTAssertEqual(data.key, "Last-Modified")
                XCTAssertEqual(data.value, value)
            case .location(let value):
                XCTAssertEqual(data.key, "Location")
                XCTAssertEqual(data.value, value)
            case .maxForwards(let value):
                XCTAssertEqual(data.key, "Max-Forwards")
                XCTAssertEqual(data.value, value)
            case .pragma(let value):
                XCTAssertEqual(data.key, "Pragma")
                XCTAssertEqual(data.value, value)
            case .proxyAuthenticate(let value):
                XCTAssertEqual(data.key, "Proxy-Authenticate")
                XCTAssertEqual(data.value, value)
            case .proxyAuthorization(let value):
                XCTAssertEqual(data.key, "Proxy-Authorization")
                XCTAssertEqual(data.value, value)
            case .range(let value):
                XCTAssertEqual(data.key, "Range")
                XCTAssertEqual(data.value, value)
            case .referer(let value):
                XCTAssertEqual(data.key, "Referer")
                XCTAssertEqual(data.value, value)
            case .retryAfter(let value):
                XCTAssertEqual(data.key, "Retry-After")
                XCTAssertEqual(data.value, value)
            case .server(let value):
                XCTAssertEqual(data.key, "Server")
                XCTAssertEqual(data.value, value)
            case .te(let value):
                XCTAssertEqual(data.key, "TE")
                XCTAssertEqual(data.value, value)
            case .trailer(let value):
                XCTAssertEqual(data.key, "Trailer")
                XCTAssertEqual(data.value, value)
            case .transferEncoding(let value):
                XCTAssertEqual(data.key, "Transfer-Encoding")
                XCTAssertEqual(data.value, value)
            case .upgrade(let value):
                XCTAssertEqual(data.key, "Upgrade")
                XCTAssertEqual(data.value, value)
            case .userAgent(let value):
                XCTAssertEqual(data.key, "User-Agent")
                XCTAssertEqual(data.value, value)
            case .vary(let value):
                XCTAssertEqual(data.key, "Vary")
                XCTAssertEqual(data.value, value)
            case .via(let value):
                XCTAssertEqual(data.key, "Via")
                XCTAssertEqual(data.value, value)
            case .warning(let value):
                XCTAssertEqual(data.key, "Warning")
                XCTAssertEqual(data.value, value)
            case .wwwAuthenticate(let value):
                XCTAssertEqual(data.key, "WWW-Authenticate")
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
    
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension PinballTests {
    
    func testCanBuildURLSessionPublisher() {
        let endpoint = Pinball.Endpoint(method: .get, scheme: .https, host: "localhost", port: 3000, user: "example", password: "password", paths: paths, queries: queries, headers: headers, data: nil)

        do {
            let _ = try URLSession.shared.dataTaskPublisher(for: endpoint)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
