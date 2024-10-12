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
        let genreResult: Observable<[String]>
    }
    
    func transform(input: Input) -> Output {
        let movieTrendListResultSubject = PublishSubject<Result<TrendingResponse, NetworkError>>()
        let tvTrendListResultSubject = PublishSubject<Result<TrendingResponse, NetworkError>>()
        let genreResultSubject = PublishSubject<[String]>()
  
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
            .flatMap { media -> Observable<[String]> in
                if media.media_type == "movie" {
                    return self.fetchMovieGenres(for: media)
                } else if media.media_type == "tv" {
                    return self.fetchTVGenres(for: media)
                } else {
                    return Observable.just([])
                }
            }
            .bind(to: genreResultSubject)
            .disposed(by: disposeBag)
        
        return Output(
            movieTrendList: movieTrendListResultSubject,
            tvTrendList: tvTrendListResultSubject,
            genreResult: genreResultSubject
        )
    }
    
    
    func fetchMovieGenres(for media: Media) -> Observable<[String]> {
     
        let genreIDs = media.genre_ids
        guard !genreIDs.isEmpty else {
            return Observable.just([])
        }
        
        return NetworkManager.shared.preformRequest(api: .genreMovie, modelType: GenreResponse.self)
                    .asObservable()
                    .flatMap { result -> Observable<[String]> in
                        switch result {
                        case .success(let genreResponse):
                           
                            var genreDictionary: [Int: String] = [:]
                            for genre in genreResponse.genres {
                                genreDictionary[genre.id] = genre.name
                            }
                            return Observable.just(genreIDs.compactMap { genreDictionary[$0] })
                            
                        case .failure(let error):
                            print("영화 장르 API 호출 오류: \(error)")
                            return Observable.just([])
                        }
                    }
    }
    
    private func fetchTVGenres(for media: Media) -> Observable<[String]> {

        let genreIDs = media.genre_ids
        guard !genreIDs.isEmpty else {
            return Observable.just([])
        }
        
        return NetworkManager.shared.preformRequest(api: .genreTV, modelType: GenreResponse.self)
                   .asObservable()
                   .flatMap { result -> Observable<[String]> in
                       switch result {
                       case .success(let genreResponse):
                  
                           var genreDictionary: [Int: String] = [:]
                           for genre in genreResponse.genres {
                               genreDictionary[genre.id] = genre.name
                           }
                           return Observable.just(genreIDs.compactMap { genreDictionary[$0] })
                           
                       case .failure(let error):
                           print("TV 장르 API 호출 오류: \(error)")
                           return Observable.just([])
                       }
                   }
    }
}
