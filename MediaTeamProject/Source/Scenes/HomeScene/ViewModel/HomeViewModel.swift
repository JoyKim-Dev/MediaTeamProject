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
        let mainPosterMedia: PublishSubject<Media>
    }
    
    struct Output {
        let movieTrendList: Observable<Result<TrendingResponse, NetworkError>>
        let tvTrendList: Observable<Result<TrendingResponse, NetworkError>>
//        let mainPosterGenreResult: Observable<Result<GenreResponse, NetworkError>>
        let movieGenreList: Observable<Result<GenreResponse, NetworkError>>
        let tvGenreList: Observable<Result<GenreResponse, NetworkError>>
    }
    
    func transform(input: Input) -> Output {
            let movieTrendListResultSubject = PublishSubject<Result<TrendingResponse, NetworkError>>()
            let tvTrendListResultSubject = PublishSubject<Result<TrendingResponse, NetworkError>>()
        let movieGenreListResultSubject = PublishSubject<Result<GenreResponse, NetworkError>>()
        let tvGenreListResultSubject = PublishSubject<Result<GenreResponse, NetworkError>>()
//            let genreResultSubject = PublishSubject<Result<GenreResponse, NetworkError>>()
            
        
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
               
        
        input.mainPosterMedia
                   .flatMap { _ in
                       Observable.zip(
                           NetworkManager.shared.preformRequest(api: .genreMovie, modelType: GenreResponse.self)
                               .asObservable()
                               .catch { error in
                                  
                                   let networkError = error as? NetworkError ?? .serverError
                                   movieGenreListResultSubject.onNext(.failure(networkError))
                                   return Observable.just(.failure(networkError))
                               },
                           NetworkManager.shared.preformRequest(api: .genreTV, modelType: GenreResponse.self)
                               .asObservable()
                               .catch { error in
             
                                   let networkError = error as? NetworkError ?? .serverError
                                   tvGenreListResultSubject.onNext(.failure(networkError))
                                   return Observable.just(.failure(networkError))
                               }
                       )
                   }
                   .subscribe(onNext: { [weak movieGenreListResultSubject, weak tvGenreListResultSubject] (movieResult, tvResult) in
                       movieGenreListResultSubject?.onNext(movieResult)
                       tvGenreListResultSubject?.onNext(tvResult)
                   })
                   .disposed(by: disposeBag)
        
          
        
               return Output(
                   movieTrendList: movieTrendListResultSubject,
                   tvTrendList: tvTrendListResultSubject, movieGenreList: movieGenreListResultSubject, tvGenreList: tvGenreListResultSubject
               )
           }
       }
