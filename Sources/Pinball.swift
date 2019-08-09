//
//  Pinball.swift
//  Pinball
//
//  Created by Aaron Wright on 7/16/19.
//  Copyright © 2019 Infinite Token LLC. All rights reserved.
//

import Foundation

public struct Pinball {
    
    public enum Error: LocalizedError {
        case urlError
        
        public var errorDescription: String? {
            switch self {
            case .urlError:
                return "URL could not be formed"
            }
        }
    }
    
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
        case head = "HEAD"
        case options = "OPTIONS"
        case trace = "TRACE"
        case connect = "CONNECT"
    }
    
    public enum Scheme: String {
        case http = "http"
        case https = "https"
        case ws = "ws"
        case wss = "wss"
    }
    
    public struct Query: Equatable {
        var key: String
        var value: String
    }
    
    public enum Header: Equatable {
        case accept(String)
        case acceptCharset(String)
        case acceptEncoding(String)
        case acceptLanguage(String)
        case acceptRanges(String)
        case age(String)
        case allow(String)
        case authorization(String)
        case cacheControl(String)
        case connection(String)
        case contentEncoding(String)
        case contentLanguage(String)
        case contentLength(String)
        case contentLocation(String)
        case contentMD5(String)
        case contentRange(String)
        case contentType(String)
        case custom(String, String)
        case date(String)
        case etag(String)
        case expect(String)
        case expires(String)
        case from(String)
        case host(String)
        case ifMatch(String)
        case ifModifiedSince(String)
        case ifNoneMatch(String)
        case ifRange(String)
        case ifUnmodifiedSince(String)
        case lastModified(String)
        case location(String)
        case maxForwards(String)
        case pragma(String)
        case proxyAuthenticate(String)
        case proxyAuthorization(String)
        case range(String)
        case referer(String)
        case retryAfter(String)
        case server(String)
        case te(String)
        case trailer(String)
        case transferEncoding(String)
        case upgrade(String)
        case userAgent(String)
        case vary(String)
        case via(String)
        case warning(String)
        case wwwAuthenticate(String)
        
        var data: (key: String, value: String) {
            switch self {
            case .accept(let value):
                return (key: "Accept", value: value)
            case .acceptCharset(let value):
                return (key: "Accept-Charset", value: value)
            case .acceptEncoding(let value):
                return (key: "Accept-Encoding", value: value)
            case .acceptLanguage(let value):
                return (key: "Accept-Language", value: value)
            case .acceptRanges(let value):
                return (key: "Accept-Ranges", value: value)
            case .age(let value):
                return (key: "Age", value: value)
            case .allow(let value):
                return (key: "Allow", value: value)
            case .authorization(let value):
                return (key: "Authorization", value: value)
            case .cacheControl(let value):
                return (key: "Cache-Control", value: value)
            case .connection(let value):
                return (key: "Connection", value: value)
            case .contentEncoding(let value):
                return (key: "Content-Encoding", value: value)
            case .contentLanguage(let value):
                return (key: "Content-Language", value: value)
            case .contentLength(let value):
                return (key: "Content-Length", value: value)
            case .contentLocation(let value):
                return (key: "Content-Location", value: value)
            case .contentMD5(let value):
                return (key: "Content-MD5", value: value)
            case .contentRange(let value):
                return (key: "Content-Range", value: value)
            case .contentType(let value):
                return (key: "Content-Type", value: value)
            case .custom(let key, let value):
                return (key: key, value: value)
            case .date(let value):
                return (key: "Date", value: value)
            case .etag(let value):
                return (key: "ETag", value: value)
            case .expect(let value):
                return (key: "Expect", value: value)
            case .expires(let value):
                return (key: "Expires", value: value)
            case .from(let value):
                return (key: "From", value: value)
            case .host(let value):
                return (key: "Host", value: value)
            case .ifMatch(let value):
                return (key: "If-Match", value: value)
            case .ifModifiedSince(let value):
                return (key: "If-Modified-Since", value: value)
            case .ifNoneMatch(let value):
                return (key: "If-None-Match", value: value)
            case .ifRange(let value):
                return (key: "If-Range", value: value)
            case .ifUnmodifiedSince(let value):
                return (key: "If-Unmodified-Since", value: value)
            case .lastModified(let value):
                return (key: "Last-Modified", value: value)
            case .location(let value):
                return (key: "Location", value: value)
            case .maxForwards(let value):
                return (key: "Max-Forwards", value: value)
            case .pragma(let value):
                return (key: "Pragma", value: value)
            case .proxyAuthenticate(let value):
                return (key: "Proxy-Authenticate", value: value)
            case .proxyAuthorization(let value):
                return (key: "Proxy-Authorization", value: value)
            case .range(let value):
                return (key: "Range", value: value)
            case .referer(let value):
                return (key: "Referer", value: value)
            case .retryAfter(let value):
                return (key: "Retry-After", value: value)
            case .server(let value):
                return (key: "Server", value: value)
            case .te(let value):
                return (key: "TE", value: value)
            case .trailer(let value):
                return (key: "Trailer", value: value)
            case .transferEncoding(let value):
                return (key: "Transfer-Encoding", value: value)
            case .upgrade(let value):
                return (key: "Upgrade", value: value)
            case .userAgent(let value):
                return (key: "User-Agent", value: value)
            case .vary(let value):
                return (key: "Vary", value: value)
            case .via(let value):
                return (key: "Via", value: value)
            case .warning(let value):
                return (key: "Warning", value: value)
            case .wwwAuthenticate(let value):
                return (key: "WWW-Authenticate", value: value)
            }
        }
    }
    
    public struct Endpoint: Equatable, CustomStringConvertible, CustomDebugStringConvertible {
        
        public var method: Method = .get
        public var scheme: Scheme = .https
        public var host: String
        public var port: Int = 80
        public var user: String?
        public var password: String?
        public var paths: [String] = []
        public var queries: [Query] = []
        public var headers: [Header] = []
        public var data: Data?
        
        public init(
            method: Method = .get,
            scheme: Scheme = .https,
            host: String,
            port: Int = 80,
            user: String? = nil,
            password: String? = nil,
            paths: [String] = [],
            queries: [Query] = [],
            headers: [Header] = [],
            data: Data? = nil
        ) {
            self.method = method
            self.scheme = scheme
            self.host = host
            self.port = port
            self.user = user
            self.password = password
            self.paths = paths
            self.queries = queries
            self.headers = headers
            self.data = data
        }
        
        public var urlComponents: URLComponents {
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme.rawValue
            urlComponents.host = host
            urlComponents.port = port == 80 ? nil : port
            urlComponents.user = user
            urlComponents.password = password
            urlComponents.path = paths.count > 0 ? "/" + paths.joined(separator: "/") : ""
            urlComponents.queryItems = queries.count > 0 ? queries.map({ (query) -> URLQueryItem in
                return URLQueryItem(name: query.key, value: query.value)
            }) : nil
            
            return urlComponents
        }
        
        public func url() throws -> URL {
            guard let url = urlComponents.url else { throw Error.urlError }
            
            return url
        }
        
        public func urlRequest(allowsCellularAccess: Bool = true, cachePolicy: URLRequest.CachePolicy? = nil) throws -> URLRequest {
            guard let url = urlComponents.url else { throw Error.urlError }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            urlRequest.httpBody = data
            urlRequest.allowsCellularAccess = allowsCellularAccess
            
            if let cachePolicy = cachePolicy {
                urlRequest.cachePolicy = cachePolicy
            }
            
            headers.forEach { (header) in
                urlRequest.addValue(header.data.value, forHTTPHeaderField: header.data.key)
            }
            
            return urlRequest
        }
        
        public var description: String {
            return urlComponents.description
        }
        
        public var debugDescription: String {
            return urlComponents.debugDescription
        }
        
    }
    
}

public extension URLSession {
    
    func dataTask(for endpoint: Pinball.Endpoint) throws -> URLSessionDataTask {
        return self.dataTask(with: try endpoint.urlRequest())
    }
    
    func dataTask(for endpoint: Pinball.Endpoint, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) throws {
        self.dataTask(with: try endpoint.urlRequest(), completionHandler: completionHandler).resume()
    }
    
    func downloadTask(for endpoint: Pinball.Endpoint) throws -> URLSessionDownloadTask {
        self.downloadTask(with: try endpoint.urlRequest())
    }
    
    func downloadTask(for endpoint: Pinball.Endpoint, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) throws {
        self.downloadTask(with: try endpoint.urlRequest(), completionHandler: completionHandler)
    }
    
    func uploadTask(for endpoint: Pinball.Endpoint, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) throws {
        self.uploadTask(with: try endpoint.urlRequest(), from: endpoint.data, completionHandler: completionHandler)
    }
    
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension URLSession {
    
    func dataTaskPublisher(for endpoint: Pinball.Endpoint) throws -> URLSession.DataTaskPublisher {
        return self.dataTaskPublisher(for: try endpoint.urlRequest())
    }
    
}
