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
    }
    
    public struct Query: Equatable {
        var key: String
        var value: String
    }
    
    public enum Header: Equatable {
        case accept(String)
        case contentType(String)
        
        var data: (key: String, value: String) {
            switch self {
            case .accept(let value):
                return (key: "Accept", value: value)
            case .contentType(let value):
                return (key: "Content-Type", value: value)
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
        self.dataTask(with: try endpoint.urlRequest(), completionHandler: completionHandler)
    }
    
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension URLSession {
    
    func dataTaskPublisher(for endpoint: Pinball.Endpoint) throws -> URLSession.DataTaskPublisher {
        return self.dataTaskPublisher(for: try endpoint.urlRequest())
    }
    
}
