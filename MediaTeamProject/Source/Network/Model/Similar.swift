//
//  Similar.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/9/24.
//

import Foundation

struct SimilarResponse: Decodable {
    let results: [Similar]
}

struct Similar: Decodable {
    let id: Int
    let poster_path: String?
}
