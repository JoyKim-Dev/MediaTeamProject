//
//  Router.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/9/24.
//

import Foundation

import Alamofire

enum Router {
    case trendingMovie //20개의 영화
    case trendingTV //20개의 드라마
    case genreMovie
    case genreTV
    case searchMovie(keyword: String, page: Int) //첫 페이지는 1값 | 0값으로 하면 에러 발생
    case creditsMovie(id: Int)
    case creditsTV(id: Int)
    case similarMovie(id: Int)
    case similarTV(id: Int)
    case videoMovie(id: Int)
    case videoTV(id: Int)
}

extension Router: TargetType {
    
    var baseURL: String {
        return APIURL.baseURL
    }
    
    var path: String {
        switch self {
        case .trendingMovie: APIURL.trendingMoviePath
        case .trendingTV: APIURL.trendingTVPath
        case .genreMovie: APIURL.genreMovie
        case .genreTV: APIURL.genreTV
        case .searchMovie: APIURL.searchMovie
        case .creditsMovie(let id): APIURL.creditsMoviePath(id: id)
        case .creditsTV(let id): APIURL.creditsTVPath(id: id)
        case .similarMovie(let id): APIURL.similarMovie(id: id)
        case .similarTV(let id): APIURL.similarTV(id: id)
        case .videoMovie(let id): APIURL.videoMovie(id: id)
        case .videoTV(let id): APIURL.videoTV(id: id)
        }
    }
    
    var header: [String : String] {
        return [
            "accept": "application/json",
            "Authorization": APIKey.apiKey
        ]
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .searchMovie(let keyword, let page):
            return [
                URLQueryItem(name: "language", value: "ko-KR"),
                URLQueryItem(name: "query", value: keyword),
                URLQueryItem(name: "page", value: String(page))
            ]
            
        case .videoTV, .videoMovie:
            return nil
        
        default:
            return [
                URLQueryItem(name: "language", value: "ko-KR")
            ]
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
