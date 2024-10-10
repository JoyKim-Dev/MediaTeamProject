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
    
    let disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        let trendList: Observable<[Media]>
    }
    
    func transform(input: Input) -> Output {
        fetchTranding()
        return Output(trendList: trendList)
    }
}

extension SearchViewModel {
    
    func fetchTranding() {
        networkManager.preformRequest(api: .trendingMovie, modelType: TrendingResponse.self)
            .flatMap { result -> Single<[Media]> in
                switch result {
                case .success(let value):
                    return Single.just(value.results)
                case .failure(let error):
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
    
}
