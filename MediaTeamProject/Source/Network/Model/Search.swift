//
//  Search.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/9/24.
//

import Foundation

struct SearchResponse: Decodable {
    let page: Int
    let results: [Search]
    let total_pages: Int
}

struct Search: Decodable {
    let id: Int
    let poster_path: String?
    
    var mediaType = "movie"
}
