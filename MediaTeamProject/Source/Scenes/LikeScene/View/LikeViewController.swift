//
//  LikeViewController.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/10/24.
//

import UIKit
import RxSwift
import RxDataSources


struct MySection {
    var header: String
    var items: [Item]
}

extension MySection : AnimatableSectionModelType {
    typealias Item = Media

    var identity: String {
        return header
    }

    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}

final class LikeViewController: BaseViewController<LikeView> {
    
    private let viewModel = LikeViewModel()
    private let disposeBag = DisposeBag()
    
    private let fetchData = PublishSubject<Void>()
    private let swipeDeleteButtonTapped = PublishSubject<Int>()
    
    
    private var dataSource: RxTableViewSectionedAnimatedDataSource<MySection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "내가 찜한 리스트"
        self.fetchData.onNext(())
    }
    
    private func setupTableView() {
        //dataSouce 설정
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            animationConfiguration: AnimationConfiguration(deleteAnimation: .right), configureCell: { dataSource, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaBackdropTableViewCell.identifier, for: indexPath) as? MediaBackdropTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.searchConfigure(item)
                return cell
            }
        )
        
        self.dataSource = dataSource
        dataSource.canEditRowAtIndexPath = { _, _ in true } //모든 행 편집 허용으로 스와이프 액션 활성화
        
        //델리게이트 설정
        rootView.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        //선택 스타일 제거
        rootView.tableView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                owner.rootView.tableView.reloadRows(at: [indexPath], with: .fade)
            }
            .disposed(by: disposeBag)
    }
    
    override func bindModel() {
        
        self.setupTableView()
        
        let input = LikeViewModel.Input(
            fetchData: fetchData,
            swipeDeleteButtonTapped: swipeDeleteButtonTapped
        )
        let output = viewModel.transform(input: input)
        
        output.mediaList
            .bind(to: rootView.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        
    }
}

extension LikeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, handler) in
            // 삭제 처리
            self.swipeDeleteButtonTapped.onNext(indexPath.row)
            
            handler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}



