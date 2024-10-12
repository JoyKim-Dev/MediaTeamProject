//
//  DetailViewController.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/11/24.
//

import UIKit
import Kingfisher
import RxSwift

final class DetailViewController: BaseViewController<DetailView> {
    
    private let viewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindModel() {
        
        let input = DetailViewModel.Input(
            xCircleButtonTapped: rootView.xCircleButton.rx.tap,
            tvCircleButtonTapped: rootView.tvCircleButton.rx.tap,
            playButtonTapped: rootView.playButton.rx.tap,
            saveButtonTapped: rootView.saveButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        self.rootView.collectionView.rx.observe(CGSize.self , "contentSize")
            .bind(with: self) { owner, size in
                owner.rootView.collectionView.snp.updateConstraints { make in
                    make.height.equalTo(size?.height ?? 0.0)
                }
            }
            .disposed(by: disposeBag)
        
        output.backdropPosterURL
            .bind(with: self) { owner, url in
                owner.rootView.backdropImageView.kf.setImage(with: url)
            }
            .disposed(by: disposeBag)
        
        output.mediaName
            .bind(to: rootView.mediaNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.voteAverage
            .bind(to: rootView.voteAverageLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.overview
            .bind(to: rootView.overviewLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.actings
            .bind(with: self) { owner, list in
                
                if list.isEmpty {
                    owner.rootView.actingLabel.text = "출연: 정보 없음"
                } else {
                    let castString = list.joined(separator: ", ")
                    owner.rootView.actingLabel.text = "출연: \(castString)"
                }
            }
            .disposed(by: disposeBag)
        
        output.directings
            .bind(with: self) { owner, list in
                
                if list.isEmpty {
                    owner.rootView.directingLabel.isHidden = true
                } else {
                    owner.rootView.directingLabel.isHidden = false
                    let castString = list.joined(separator: ", ")
                    owner.rootView.directingLabel.text = "크리에이터: \(castString)"
                }
            }
            .disposed(by: disposeBag)
        
        output.similars
            .bind(to: rootView.collectionView.rx.items(cellIdentifier: MediaPosterCell.identifier, cellType: MediaPosterCell.self)) { row, element, cell in
                cell.moviePosterImageView.kf.setImage(with: APIURL.makeTMDBImageURL(path: element.poster_path ?? ""))
            }
            .disposed(by: disposeBag)
        
        output.xCircleButtonTapped
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.tvCircleButtonTapped
            .bind(with: self) { owner, _ in
                print("TV 버튼 선택됨")
            }
            .disposed(by: disposeBag)
        
        output.showPopupMessageView
            .bind(with: self) { owner, messageType in
                var vc: PopupMessageViewController
                switch messageType {
                case .newSave:
                    vc = PopupMessageViewController(viewModel: PopupMessageViewModel(messageType: .newSave))
                case .alreadySave:
                    vc = PopupMessageViewController(viewModel: PopupMessageViewModel(messageType: .alreadySave))
                }
                
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.creditsNetworkError
            .bind(with: self) { owner, _ in
                owner.rootView.actingLabel.isHidden = true
                owner.rootView.directingLabel.isHidden = true
            }
            .disposed(by: disposeBag)
        
        output.similarNetworkError
            .bind(with: self) { owner, _ in
                owner.rootView.similarTitleLabel.isHidden = true
                owner.rootView.collectionView.isHidden = true
            }
            .disposed(by: disposeBag)
    }
}

