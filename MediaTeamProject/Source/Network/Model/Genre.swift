//
//  Genre.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/9/24.
//

import Foundation

struct GenreResponse: Decodable {
    let genres: [Genre]
    
    var genreDictionary: [Int: String] { //Media의 genre_id 값을 Key로 사용하면 하나의 장르 name 을 얻을 수 있습니다.
        Dictionary(uniqueKeysWithValues: genres.map { ($0.id, $0.name) })
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
