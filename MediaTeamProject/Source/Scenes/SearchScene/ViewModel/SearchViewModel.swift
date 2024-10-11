//
//  SearchViewModel.swift
//  MediaTeamProject
//
//  Created by 전준영 on 10/9/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: BaseViewModel {
    
    private let networkManager = NetworkManager.shared
    private let trendList = PublishSubject<[Media]>()
    private let searchResult = BehaviorRelay<[Media]>(value: [])
    
    private var currentPage = 1
    private var totalResults = 0
    private var isLoading = false
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchText: Observable<String>
        let loadMoreTrigger: Observable<Void>
    }
    
    struct Output {
        let trendList: Observable<[Media]>
        let searchResult: Observable<[Media]>
    }
    
    func transform(input: Input) -> Output {
        fetchTranding()
        
        input.searchText
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .flatMapLatest { [weak self] query -> Observable<[Media]> in
                guard let self = self else { return Observable.just([]) }
                self.currentPage = 1
                return self.performSearch(query: query, page: self.currentPage)
            }
            .bind(with: self, onNext: { owner, newResult in
                owner.searchResult.accept(newResult)
            })
            .disposed(by: disposeBag)
        
        input.loadMoreTrigger
            .withLatestFrom(input.searchText)
            .flatMapLatest { [weak self] query -> Observable<[Media]> in
                guard let self = self, !self.isLoading else { return Observable.just([]) }
                self.isLoading = true
                self.currentPage += 1
                return self.performSearch(query: query, page: self.currentPage)
            }
            .bind(with: self, onNext: { owner, newResult in
                let currentResults = owner.searchResult.value
                owner.searchResult.accept(currentResults + newResult)
                owner.isLoading = false
            })
            .disposed(by: disposeBag)
        
        return Output(trendList: trendList,
                      searchResult: searchResult.asObservable())
    }
}

extension SearchViewModel {
    
    func fetchTranding() {
        networkManager.preformRequest(api: .trendingMovie, modelType: TrendingResponse.self)
            .flatMap { result -> Single<[Media]> in
                switch result {
                case .success(let value):
                    return Single.just(value.results)
                case .failure(_):
                    return Single.just([])
                }
            }
            .subscribe(with: self) { owner, trendResult in
                owner.trendList.onNext(trendResult)
            } onFailure: { owner, error in
                owner.trendList.onNext([])
            }
            .disposed(by: disposeBag)
    }
    
    private func performSearch(query: String, page: Int) -> Observable<[Media]> {
        return networkManager.preformRequest(api: .searchMovie(keyword: query, page: page), modelType: SearchResponse.self)
            .flatMap { result -> Single<[Media]> in
                switch result {
                case .success(let response):
                    return Single.just(response.results)
                case .failure(_):
                    return Single.just([])
                }
            }
            .asObservable()
            .catch { _ in
                return Observable.just([])
            }
            .do(onDispose: {
                print("check '\(query)' disposed")
            })
    }
    
}
