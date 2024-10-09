//
//  Video.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/9/24.
//

import Foundation

struct VideoResponse: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let key: String
    let type: String
}
