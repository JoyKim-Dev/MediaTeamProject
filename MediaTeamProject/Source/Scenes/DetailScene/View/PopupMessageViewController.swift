//
//  PopupMessageViewController.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/12/24.
//

import UIKit
import RxSwift

final class PopupMessageViewController: BaseViewController<PopupMessageView> {
    
    private let viewModel: PopupMessageViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: PopupMessageViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    override func bindModel() {
        let input = PopupMessageViewModel.Input(
            checkButtonTapped: rootView.checkButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.message
            .bind(to: rootView.messageLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.checkButtonTapped
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
