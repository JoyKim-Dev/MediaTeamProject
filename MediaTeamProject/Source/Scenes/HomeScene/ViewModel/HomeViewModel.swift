//
//  HomeViewModel.swift
//  MediaTeamProject
//
//  Created by Joy Kim on 10/9/24.
//

import Foundation
import RxCocoa
import RxSwift

final class HomeViewModel: BaseViewModel {
    
    let disposeBag = DisposeBag()

    struct Input {
        let viewWillAppear: Observable<Void>
    }
    
    struct Output {
        let movieTrendList: Observable<Result<TrendingResponse, NetworkError>>
        let tvTrendList: Observable<Result<TrendingResponse, NetworkError>>
    }
    
    func transform(input: Input) -> Output {
            let movieTrendListResultSubject = PublishSubject<Result<TrendingResponse, NetworkError>>()
            let tvTrendListResultSubject = PublishSubject<Result<TrendingResponse, NetworkError>>()
            
        input.viewWillAppear
                   .flatMap { _ in
                       Observable.zip(
                           NetworkManager.shared.preformRequest(api: .trendingMovie, modelType: TrendingResponse.self)
                               .asObservable()
                               .catch { error in
                                  
                                   let networkError = error as? NetworkError ?? .serverError
                                   movieTrendListResultSubject.onNext(.failure(networkError))
                                   return Observable.just(.failure(networkError))
                               },
                           NetworkManager.shared.preformRequest(api: .trendingTV, modelType: TrendingResponse.self)
                               .asObservable()
                               .catch { error in
             
                                   let networkError = error as? NetworkError ?? .serverError
                                   tvTrendListResultSubject.onNext(.failure(networkError))
                                   return Observable.just(.failure(networkError))
                               }
                       )
                   }
                   .subscribe(onNext: { [weak movieTrendListResultSubject, weak tvTrendListResultSubject] (movieResult, tvResult) in
                       movieTrendListResultSubject?.onNext(movieResult)
                       tvTrendListResultSubject?.onNext(tvResult)
                   })
                   .disposed(by: disposeBag)
               
               return Output(
                   movieTrendList: movieTrendListResultSubject,
                   tvTrendList: tvTrendListResultSubject
               )
           }
       }
