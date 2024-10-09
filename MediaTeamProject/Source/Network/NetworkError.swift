//
//  NetworkError.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/9/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseFailed
    case noInternetConnection
    case serverError
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Error: 유효하지 않은 URL 문제 발생"
        case .responseFailed:
            return "Error: 응답 실패"
        case .noInternetConnection:
            return "Error: 인터넷 연결 오류"
        case .serverError:
            return "Error: 서버에 문제 발생"
        }
    }
}
