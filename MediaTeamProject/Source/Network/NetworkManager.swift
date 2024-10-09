//
//  NetworkManager.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/9/24.
//

import Foundation

import Alamofire
import RxSwift

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    
    func preformRequest<T: Decodable>(api: Router, modelType: T.Type) -> Single<Result<T, NetworkError>> {
        
        return Single.create { single -> Disposable in
         
            do {
                let request = try api.asURLRequest()
                
                AF.request(request)
                    .validate(statusCode: 200...299)
                    .responseDecodable(of: T.self) { response in
                        switch response.result {
                        case .success(let data):
                            single(.success(.success(data)))
                        case .failure(let error):
                            print(error)
                            if let urlError = error.asAFError?.underlyingError as? URLError, urlError.code == .notConnectedToInternet {
                                single(.success(.failure(.noInternetConnection)))
                            } else {
                                if response.response?.statusCode ?? 0 == 500 {
                                    single(.success(.failure(.serverError)))
                                } else {
                                    single(.success(.failure(.responseFailed)))
                                }
                            }
                        }
                }
            } catch {
                single(.success(.failure(NetworkError.invalidURL)))
            }
            
            return Disposables.create()
        }
    }
}
