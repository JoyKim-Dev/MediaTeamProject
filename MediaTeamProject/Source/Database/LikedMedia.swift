//
//  TvRealmModel.swift
//  MediaTeamProject
//
//  Created by Joy Kim on 10/9/24.
//

import Foundation
import RealmSwift

final class LikedMedia: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var backdropPath: String
    @Persisted var title: String
    @Persisted var vote_average: Double
    @Persisted var overview: String
    // 미디어 상세 화면에서 mediaType에 맞는 api를 호출하기 위한 항목추가
    @Persisted var mediaType: String
    @Persisted var date: Date = Date()

    convenience init(id: Int, backdropPath: String, title: String, vote_average: Double, overview: String, mediaType: String, date: Date) {
        self.init()
        self.id = id
        self.backdropPath = backdropPath
        self.title = title
        self.vote_average = vote_average
        self.overview = overview
        self.mediaType = mediaType
        self.date = date
    }
}
