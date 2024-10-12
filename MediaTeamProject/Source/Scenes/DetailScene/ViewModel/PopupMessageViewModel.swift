//
//  PopupMessageViewModel.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/12/24.
//

import Foundation
import RxSwift
import RxCocoa

final class PopupMessageViewModel: BaseViewModel {
    
    enum MessageType: String {
        case newSave = "미디어를 저장했어요 :)"
        case alreadySave = "이미 저장된 미디어에요 :)"
    }
    private var messageType: MessageType
    
    let disposeBag = DisposeBag()
    
    init(messageType: MessageType) {
        self.messageType = messageType
    }
    
    struct Input {
        let checkButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let checkButtonTapped: ControlEvent<Void>
        let message: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        
        let message = Observable.just(messageType.rawValue)
        
        
        return Output(
            checkButtonTapped: input.checkButtonTapped,
            message: message
        )
    }
}
