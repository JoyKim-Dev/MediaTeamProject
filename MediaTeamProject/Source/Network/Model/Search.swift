//
//  Search.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/9/24.
//

import Foundation

struct SearchResponse: Decodable {
    let page: Int
    let results: [Media]
    let total_pages: Int
}
