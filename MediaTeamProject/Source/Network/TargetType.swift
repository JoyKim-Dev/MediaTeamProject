//
//  TargetType.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/9/24.
//

import Foundation

import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var header: [String: String] { get }
    var query: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        
        guard var urlComponents = URLComponents(string: baseURL + path) else {
            throw URLError(.badURL)
        }
        
        urlComponents.queryItems = query
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header
        
        return request
    }
}
