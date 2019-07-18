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
    
    func testCanBuildURLComponents() {
        let paths: [String] = ["widgets"]
        let queries: [Pinball.Query] = [
            Pinball.Query(key: "foo", value: "bar")
        ]
        
        var endpoint = Pinball.Endpoint(method: .get, scheme: .https, host: "localhost", port: 3000, user: "example", password: "password", paths: paths, queries: queries, headers: [], data: nil)
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
        let paths: [String] = ["widgets"]
        let queries: [Pinball.Query] = [
            Pinball.Query(key: "foo", value: "bar")
        ]
        
        let endpoint = Pinball.Endpoint(method: .get, scheme: .https, host: "localhost", port: 3000, user: "example", password: "password", paths: paths, queries: queries, headers: [], data: nil)
        
        XCTAssertNoThrow(try endpoint.url())
    }
    
    func testCanBuildURLRequest() {
        let headers: [Pinball.Header] = [
            Pinball.Header.accept("example")
        ]
        let endpoint = Pinball.Endpoint(method: .get, scheme: .https, host: "localhost", port: 3000, user: "example", password: "password", paths: [], queries: [], headers: headers, data: nil)
        
        XCTAssertNoThrow(try endpoint.urlRequest(allowsCellularAccess: true, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData))
    }
    
    func testCanDescribe() {
        let endpoint = Pinball.Endpoint(host: "localhost")
        
        XCTAssertNotNil(endpoint.description)
        XCTAssertNotNil(endpoint.debugDescription)
    }
    
    func testCanDescribeError() {
        let error = Pinball.Error.urlError
        
        XCTAssertEqual(error.localizedDescription, "URL could not be formed")
    }
    
    func testCanConvertHeaderToData() {
        let headers: [Pinball.Header] = [
            Pinball.Header.accept("example"),
            Pinball.Header.acceptCharset("example"),
            Pinball.Header.acceptEncoding("example"),
            Pinball.Header.acceptLanguage("example"),
            Pinball.Header.acceptRanges("example"),
            Pinball.Header.age("example"),
            Pinball.Header.allow("example"),
            Pinball.Header.authorization("example"),
            Pinball.Header.cacheControl("example"),
            Pinball.Header.connection("example"),
            Pinball.Header.contentEncoding("example"),
            Pinball.Header.contentLanguage("example"),
            Pinball.Header.contentLength("example"),
            Pinball.Header.contentLocation("example"),
            Pinball.Header.contentMD5("example"),
            Pinball.Header.contentRange("example"),
            Pinball.Header.contentType("example"),
            Pinball.Header.custom("example", "example"),
            Pinball.Header.date("example"),
            Pinball.Header.etag("example"),
            Pinball.Header.expect("example"),
            Pinball.Header.expires("example"),
            Pinball.Header.from("example"),
            Pinball.Header.host("example"),
            Pinball.Header.ifMatch("example"),
            Pinball.Header.ifModifiedSince("example"),
            Pinball.Header.ifNoneMatch("example"),
            Pinball.Header.ifRange("example"),
            Pinball.Header.ifUnmodifiedSince("example"),
            Pinball.Header.lastModified("example"),
            Pinball.Header.location("example"),
            Pinball.Header.maxForwards("example"),
            Pinball.Header.pragma("example"),
            Pinball.Header.proxyAuthenticate("example"),
            Pinball.Header.proxyAuthorization("example"),
            Pinball.Header.range("example"),
            Pinball.Header.referer("example"),
            Pinball.Header.retryAfter("example"),
            Pinball.Header.server("example"),
            Pinball.Header.te("example"),
            Pinball.Header.trailer("example"),
            Pinball.Header.transferEncoding("example"),
            Pinball.Header.upgrade("example"),
            Pinball.Header.userAgent("example"),
            Pinball.Header.vary("example"),
            Pinball.Header.via("example"),
            Pinball.Header.warning("example"),
            Pinball.Header.wwwAuthenticate("example")
        ]
        
        headers.forEach { (header) in
            let data = header.data
            
            switch header {
            case .accept(_):
                XCTAssertEqual(data.key, "Accept")
                XCTAssertEqual(data.value, "example")
            case .acceptCharset(_):
                XCTAssertEqual(data.key, "Accept-Charset")
                XCTAssertEqual(data.value, "example")
            case .acceptEncoding(_):
                XCTAssertEqual(data.key, "Accept-Encoding")
                XCTAssertEqual(data.value, "example")
            case .acceptLanguage(_):
                 XCTAssertEqual(data.key, "Accept-Language")
                XCTAssertEqual(data.value, "example")
            case .acceptRanges(_):
                XCTAssertEqual(data.key, "Accept-Ranges")
                XCTAssertEqual(data.value, "example")
            case .age(_):
                XCTAssertEqual(data.key, "Age")
                XCTAssertEqual(data.value, "example")
            case .allow(_):
                XCTAssertEqual(data.key, "Allow")
                XCTAssertEqual(data.value, "example")
            case .authorization(_):
                 XCTAssertEqual(data.key, "Authorization")
                XCTAssertEqual(data.value, "example")
            case .cacheControl(_):
                XCTAssertEqual(data.key, "Cache-Control")
                XCTAssertEqual(data.value, "example")
            case .connection(_):
                XCTAssertEqual(data.key, "Connection")
                XCTAssertEqual(data.value, "example")
            case .contentEncoding(_):
                XCTAssertEqual(data.key, "Content-Encoding")
                XCTAssertEqual(data.value, "example")
            case .contentLanguage(_):
                XCTAssertEqual(data.key, "Content-Language")
                XCTAssertEqual(data.value, "example")
            case .contentLength(_):
                XCTAssertEqual(data.key, "Content-Length")
                XCTAssertEqual(data.value, "example")
            case .contentLocation(_):
                XCTAssertEqual(data.key, "Content-Location")
                XCTAssertEqual(data.value, "example")
            case .contentMD5(_):
                XCTAssertEqual(data.key, "Content-MD5")
                XCTAssertEqual(data.value, "example")
            case .contentRange(_):
                XCTAssertEqual(data.key, "Content-Range")
                XCTAssertEqual(data.value, "example")
            case .contentType(_):
                XCTAssertEqual(data.key, "Content-Type")
                XCTAssertEqual(data.value, "example")
            case .custom(let key, _):
                XCTAssertEqual(data.key, key)
                XCTAssertEqual(data.value, "example")
            case .date(_):
                XCTAssertEqual(data.key, "Date")
                XCTAssertEqual(data.value, "example")
            case .etag(_):
                XCTAssertEqual(data.key, "ETag")
                XCTAssertEqual(data.value, "example")
            case .expect(_):
                XCTAssertEqual(data.key, "Expect")
                XCTAssertEqual(data.value, "example")
            case .expires(_):
                XCTAssertEqual(data.key, "Expires")
                XCTAssertEqual(data.value, "example")
            case .from(_):
                XCTAssertEqual(data.key, "From")
                XCTAssertEqual(data.value, "example")
            case .host(_):
                XCTAssertEqual(data.key, "Host")
                XCTAssertEqual(data.value, "example")
            case .ifMatch(_):
                XCTAssertEqual(data.key, "If-Match")
                XCTAssertEqual(data.value, "example")
            case .ifModifiedSince(_):
                XCTAssertEqual(data.key, "If-Modified-Since")
                XCTAssertEqual(data.value, "example")
            case .ifNoneMatch(_):
                XCTAssertEqual(data.key, "If-None-Match")
                XCTAssertEqual(data.value, "example")
            case .ifRange(_):
                XCTAssertEqual(data.key, "If-Range")
                XCTAssertEqual(data.value, "example")
            case .ifUnmodifiedSince(_):
                XCTAssertEqual(data.key, "If-Unmodified-Since")
                XCTAssertEqual(data.value, "example")
            case .lastModified(_):
                XCTAssertEqual(data.key, "Last-Modified")
                XCTAssertEqual(data.value, "example")
            case .location(_):
                XCTAssertEqual(data.key, "Location")
                XCTAssertEqual(data.value, "example")
            case .maxForwards(_):
                XCTAssertEqual(data.key, "Max-Forwards")
                XCTAssertEqual(data.value, "example")
            case .pragma(_):
                XCTAssertEqual(data.key, "Pragma")
                XCTAssertEqual(data.value, "example")
            case .proxyAuthenticate(_):
                XCTAssertEqual(data.key, "Proxy-Authenticate")
                XCTAssertEqual(data.value, "example")
            case .proxyAuthorization(_):
                XCTAssertEqual(data.key, "Proxy-Authorization")
                XCTAssertEqual(data.value, "example")
            case .range(_):
                XCTAssertEqual(data.key, "Range")
                XCTAssertEqual(data.value, "example")
            case .referer(_):
                XCTAssertEqual(data.key, "Referer")
                XCTAssertEqual(data.value, "example")
            case .retryAfter(_):
                XCTAssertEqual(data.key, "Retry-After")
                XCTAssertEqual(data.value, "example")
            case .server(_):
                XCTAssertEqual(data.key, "Server")
                XCTAssertEqual(data.value, "example")
            case .te(_):
                XCTAssertEqual(data.key, "TE")
                XCTAssertEqual(data.value, "example")
            case .trailer(_):
                XCTAssertEqual(data.key, "Trailer")
                XCTAssertEqual(data.value, "example")
            case .transferEncoding(_):
                XCTAssertEqual(data.key, "Transfer-Encoding")
                XCTAssertEqual(data.value, "example")
            case .upgrade(_):
                XCTAssertEqual(data.key, "Upgrade")
                XCTAssertEqual(data.value, "example")
            case .userAgent(_):
                XCTAssertEqual(data.key, "User-Agent")
                XCTAssertEqual(data.value, "example")
            case .vary(_):
                XCTAssertEqual(data.key, "Vary")
                XCTAssertEqual(data.value, "example")
            case .via(_):
                XCTAssertEqual(data.key, "Via")
                XCTAssertEqual(data.value, "example")
            case .warning(_):
                XCTAssertEqual(data.key, "Warning")
                XCTAssertEqual(data.value, "example")
            case .wwwAuthenticate(_):
                XCTAssertEqual(data.key, "WWW-Authenticate")
                XCTAssertEqual(data.value, "example")
            }
        }
    }
    
    func testCanBuildURLSessionTasks() {
        let endpoint = Pinball.Endpoint(host: "localhost")
        
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
        
        do {
            let _ = try URLSession.shared.downloadTask(for: endpoint)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        do {
            let _ = try URLSession.shared.downloadTask(for: endpoint, completionHandler: { (_, _, _) in })
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        do {
            let _ = try URLSession.shared.uploadTask(for: endpoint, completionHandler: { (_, _, _) in })
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension PinballTests {
    
    func testCanBuildURLSessionPublisher() {
        let endpoint = Pinball.Endpoint(host: "localhost")

        do {
            let _ = try URLSession.shared.dataTaskPublisher(for: endpoint)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
