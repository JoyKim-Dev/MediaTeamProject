//
//  LikeViewModel.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/10/24.
//

import Foundation
import RxSwift
import RxRelay
import RealmSwift

final class LikeViewModel: BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    private var mediaList: [LikedMedia] = []
    
    private var notificationToken: NotificationToken?
    
    struct Input {
        let viewDidLoad: PublishSubject<Void>
        let swipeDeleteButtonTapped: PublishSubject<Int>
        let playImageButtonTapped: PublishSubject<Void>
    }
    
    struct Output {
        let mediaList: PublishSubject<[LikeSection]>
        let succeedDelete: PublishSubject<Int>
        let playImageButtonTapped: PublishSubject<Void>
        let hideNoDataMessageLabel: PublishRelay<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let mediaList = PublishSubject<[LikeSection]>()
        let succeedDelete = PublishSubject<Int>()
        let hideNoDataMessageLabel = PublishRelay<Bool>()
        
        
        input.viewDidLoad
            .bind(with: self) { [weak self] owner, _ in
                guard let self else { return }
                let likeMedias = RealmRepository.shared.fetchAll()
                
                owner.notificationToken = likeMedias.observe { changes in
                    switch changes {
                    case .initial:
                        self.mediaList = Array(likeMedias)
                        mediaList.onNext([LikeSection(header: "", items: Array(likeMedias))])
                        
                    case .update(_, _, _, _):
                        print("DEBUG: Realm 데이터 변화 감지됨")
                        self.mediaList = Array(likeMedias)
                        mediaList.onNext([LikeSection(header: "", items: owner.mediaList)])
                        
                        
                    case .error(let error):
                        print(error)
                    }
                    //데이터 없을 시 메시지 레이블 표시
                    self.mediaList.isEmpty == true ? hideNoDataMessageLabel.accept(false) : hideNoDataMessageLabel.accept(true)
                }
            }
            .disposed(by: disposeBag)
        
        input.swipeDeleteButtonTapped
            .bind(with: self) { owner, row in
                //먼저 rxdatasource 섹션 아이템 쪽에서 타겟 제거
                let id = owner.mediaList[row].id
                owner.mediaList.remove(at: row)
                mediaList.onNext([LikeSection(header: "", items: owner.mediaList)])
                
                //Realm에서 타겟 제거
                RealmRepository.shared.deleteItem(id)
            }
            .disposed(by: disposeBag)
        
        
        return Output(
            mediaList: mediaList,
            succeedDelete: succeedDelete,
            playImageButtonTapped: input.playImageButtonTapped,
            hideNoDataMessageLabel: hideNoDataMessageLabel
        )
    }
}
