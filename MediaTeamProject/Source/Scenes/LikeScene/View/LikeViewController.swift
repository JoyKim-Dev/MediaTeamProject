//
//  LikeViewController.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/10/24.
//

import UIKit
import RxSwift
import RxDataSources

struct LikeSection {
    var header: String
    var items: [Item]
}

extension LikeSection : AnimatableSectionModelType {
    typealias Item = LikedMedia

    var identity: String {
        return header
    }

    init(original: LikeSection, items: [Item]) {
        self = original
        self.items = items
    }
}

final class LikeViewController: BaseViewController<LikeView> {
    
    private let viewModel = LikeViewModel()
    private let disposeBag = DisposeBag()
    
    private let viewLoad = PublishSubject<Void>()
    private let swipeDeleteButtonTapped = PublishSubject<Int>()
    private let playImageButtonTapped = PublishSubject<Void>()
    
    private var dataSource: RxTableViewSectionedAnimatedDataSource<LikeSection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "내가 찜한 리스트"
        self.viewLoad.onNext(())
    }
    
    private func setupTableView() {
        //dataSouce 설정
        let dataSource = RxTableViewSectionedAnimatedDataSource<LikeSection>(
            animationConfiguration: AnimationConfiguration(deleteAnimation: .right), configureCell: { dataSource, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaBackdropTableViewCell.identifier, for: indexPath) as? MediaBackdropTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.likeConfigure(item)
                
                cell.playImage.rx.tap
                    .bind(with: self, onNext: { owner, _ in
                        owner.playImageButtonTapped.onNext(())
                    })
                    .disposed(by: cell.disposeBag)
                
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
            viewDidLoad: viewLoad,
            swipeDeleteButtonTapped: swipeDeleteButtonTapped,
            playImageButtonTapped: playImageButtonTapped
        )
        let output = viewModel.transform(input: input)
        
        output.hideNoDataMessageLabel
            .bind(to: rootView.noDataLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.mediaList
            .bind(to: rootView.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        output.playImageButtonTapped
            .bind(with: self) { owner, _ in
                print("버튼 선택됨")
            }
            .disposed(by: disposeBag)
        
        rootView.tableView.rx.modelSelected(LikedMedia.self)
            .bind(with: self) { owner, data in
                //미디어 상세화면에서 받는 데이터 모델로 변경
                let media = Media(id: data.id, name: data.title, title: data.title, overview: data.overview, poster_path: nil, backdrop_path: data.backdropPath, genre_ids: [], vote_average: data.vote_average, media_type: data.mediaType)
                //데이터 전달 및 화면전환
                let detailVC = DetailViewController(viewModel: DetailViewModel(media: media))
                owner.present(detailVC, animated: true)
            }
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



