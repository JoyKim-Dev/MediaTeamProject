//
//  HomeViewController.swift
//  MediaTeamProject
//
//  Created by Joy Kim on 10/9/24.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class HomeViewController: BaseViewController<HomeView> {
    
    
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    private var movieTrendList = BehaviorRelay<[Media]>(value: [])
    private var tvTrendList = BehaviorRelay<[Media]>(value: [])
    
    private let viewWillAppearTrigger = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearTrigger.onNext(())
    }
}

extension HomeViewController {
    private func setupNavigationBar() {
        
        let rightBarItemOne = UIBarButtonItem(image: AppIcon.sparklesTV, style: .plain, target: nil, action: nil)
        let rightBarItemTwo = UIBarButtonItem(image: AppIcon.magnifyingGlass, style: .plain, target: nil, action: nil)
        let leftLabel = UILabel()
        leftLabel.text = "N"
        leftLabel.contentMode = .scaleAspectFill
        leftLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)
        leftLabel.textColor = .myAppRed
        
        let leftBarItem = UIBarButtonItem(customView: leftLabel)
        navigationItem.rightBarButtonItems = [rightBarItemTwo, rightBarItemOne]
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(viewWillAppear: viewWillAppearTrigger)
        let output = viewModel.transform(input: input)
        
        output.movieTrendList
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let media):
                    let list = media.results
                    self?.movieTrendList.accept(list)
                    self?.updatePosterImage()
                case .failure(let error):
                    print("movieList 바인딩 실패: \(error)")
                }
            })
            .disposed(by: disposeBag)
        
        output.tvTrendList
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let media):
                    let list = media.results
                    self?.tvTrendList.accept(list)
                    self?.updatePosterImage()
                case .failure(let error):
                    print("tvList 바인딩 실패: \(error)")
                }
            })
            .disposed(by: disposeBag)
        
        movieTrendList
            .map { Array($0.prefix(10)) }
            .bind(to: rootView.movieCollectionView.rx.items(cellIdentifier: MediaPosterCell.identifier, cellType: MediaPosterCell.self)) {
                item, element, cell in
                cell.configUI(data: element)
            }
            .disposed(by: disposeBag)
        
        tvTrendList
            .map { Array($0.prefix(10)) }
            .bind(to: rootView.tvCollectionView.rx.items(cellIdentifier: MediaPosterCell.identifier, cellType: MediaPosterCell.self)) {
                item, element, cell in
                cell.configUI(data: element)
                cell.clipsToBounds =  true
                cell.layer.cornerRadius = 10
            }
            .disposed(by: disposeBag)
    }
    
    private func updatePosterImage() {
        let combinedList = movieTrendList.value + tvTrendList.value
        
        guard let randomMedia = combinedList.randomElement(),
              let posterPath = randomMedia.poster_path else {
            self.rootView.posterImageView.image = UIImage(systemName: "star")
            return
        }
        
        let URL = URL(string: "https://image.tmdb.org/t/p/w780\(posterPath)")
        self.rootView.posterImageView.kf.setImage(with: URL)
        self.rootView.posterImageView.contentMode = .scaleAspectFill
        
    }
}


