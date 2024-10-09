//
//  Credit.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/9/24.
//

import Foundation

struct CreditsResponse: Decodable {
    let id: Int
    let results: [Credit]
    
    enum CodingKeys: String, CodingKey {
        case id
        case results = "cast"
    }
}

struct Credit: Decodable {
    let known_for_department: String //역할
    let name: String //성함
}
