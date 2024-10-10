//
//  LikeViewController.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/10/24.
//

import UIKit
import RxSwift

final class LikeViewController: BaseViewController<LikeView> {
    
    private let viewModel = LikeViewModel()
    private let disposeBag = DisposeBag()
    
    private let fetchData = PublishSubject<Void>()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationItem.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "내가 찜한 리스트"
        fetchData.onNext(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindModel() {
        
        let input = LikeViewModel.Input(
            fetchData: fetchData
        )
        let output = viewModel.transform(input: input)
        
        output.mediaList
            .bind(to: rootView.tableView.rx.items(cellIdentifier: MediaBackdropTableViewCell.identifier, cellType: MediaBackdropTableViewCell.self)) { row, element, cell in
                cell.searchConfigure(element)
            }
            .disposed(by: disposeBag)
    }
}
