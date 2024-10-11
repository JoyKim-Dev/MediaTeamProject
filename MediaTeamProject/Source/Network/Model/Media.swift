//
//  Media.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/9/24.
//

import Foundation

struct Media: Decodable {
    let id: Int
    let name: String?
    let title: String?
    let overview: String? //줄거리
    let poster_path: String? //메인 포스터 이미지 주소
    let backdrop_path: String? //배경 포스터 이미지 주소
    let genre_ids: [Int]
    let vote_average: Double //평점
    let media_type: String? //"tv" 혹은 "movie"
    
    var mediaTitle: String { //영화 제목 또는 드라마 제목을 얻으려면 이 프로퍼티를 이용해 주세요!
        return name == nil ? title ?? "" : name ?? ""
    }
    
    var voteAverage: Double { //소수점 1자리 값만 얻으려면 이 프로퍼티를 이용해 주세요!
        return (vote_average * 10).rounded() / 10
    }
}
