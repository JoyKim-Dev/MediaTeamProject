//
//  DetailViewModel.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/11/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel: BaseViewModel {
    
    private let media: Media
    
    private let actings = PublishSubject<[String]>()
    private let directings = PublishSubject<[String]>()
    private let similars = PublishSubject<[Similar]>()
    
    let disposeBag = DisposeBag()
    
    init(media: Media) {
        self.media = media
    }
    
    struct Input {
        let xCircleButtonTapped: ControlEvent<Void>
        let tvCircleButtonTapped: ControlEvent<Void>
        let playButtonTapped: ControlEvent<Void>
        let saveButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let backdropPosterURL: Observable<URL?>
        let mediaName: Observable<String>
        let voteAverage: Observable<String>
        let overview: Observable<String?>
        let actings: PublishSubject<[String]>
        let directings: PublishSubject<[String]>
        let similars: PublishSubject<[Similar]>
        let xCircleButtonTapped: ControlEvent<Void>
        let tvCircleButtonTapped: ControlEvent<Void>
        let showPopupMessageView: PublishSubject<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let media = Observable.just(self.media)
            .share()
        
        let backdropPosterURL = media.map { $0.backdrop_path ?? "" }
            .map { APIURL.makeTMDBImageURL(path: $0) }
        let mediaName = media.map { $0.mediaTitle }
        let voteAverage = media.map { $0.voteAverage }
            .map { String($0) }
        let overview =  media.map { $0.overview }
        
        let showPopupMessageView = PublishSubject<Void>()
        
        media
            .bind(with: self) { owner, data in
                owner.fetchCredits(id: data.id, type: data.media_type ?? "")
            }
            .disposed(by: disposeBag)
        
        media
            .bind(with: self) { owner, data in
                owner.fetchSimilar(id: data.id, type: data.media_type ?? "")
            }
            .disposed(by: disposeBag)
        
        input.saveButtonTapped
            .bind(with: self) { owner, _ in
                //렘 저장 처리
                
            
                showPopupMessageView.onNext(())
            }
            .disposed(by: disposeBag)
            
        
        
        
        
        
        
        return Output(
            backdropPosterURL: backdropPosterURL,
            mediaName: mediaName,
            voteAverage: voteAverage,
            overview: overview,
            actings: actings,
            directings: directings,
            similars: similars,
            xCircleButtonTapped: input.xCircleButtonTapped,
            tvCircleButtonTapped: input.tvCircleButtonTapped,
            showPopupMessageView: showPopupMessageView
        )
    }
}

extension DetailViewModel {
    
    private func fetchCredits(id: Int, type: String) {
        
        var api: Router
        
        if type == "tv" {
            api = Router.creditsTV(id: id)
        } else {
            api = Router.creditsMovie(id: id)
        }
        
        NetworkManager.shared.preformRequest(api: api, modelType: CreditsResponse.self)
            .asObservable()
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    let actingNames = value.results.filter { $0.known_for_department == "Acting" }.prefix(3).map { $0.name }
                    owner.actings.onNext(actingNames)
                    
                    let directingNames = value.results.filter { $0.known_for_department == "Directing" }.prefix(3).map { $0.name }
                    owner.directings.onNext(directingNames)
                
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchSimilar(id: Int, type: String) {
        
        var api: Router
        
        if type == "tv" {
            api = Router.similarTV(id: id)
        } else {
            api = Router.similarMovie(id: id)
        }
        
        NetworkManager.shared.preformRequest(api: api, modelType: SimilarResponse.self)
            .asObservable()
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    owner.similars.onNext(value.results)
                
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}
