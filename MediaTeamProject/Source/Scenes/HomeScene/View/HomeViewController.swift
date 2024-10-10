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
    private let mainPosterMedia = PublishSubject<Media>()
    private let tvGenreList = BehaviorRelay<[Genre]>(value: [])
    private let movieGenreList = BehaviorRelay<[Genre]>(value: [])
    
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
        let leftBarItem = UIBarButtonItem(image: AppIcon.netflixLogo, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [rightBarItemTwo, rightBarItemOne]
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(viewWillAppear: viewWillAppearTrigger, mainPosterMedia: mainPosterMedia)
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
        
        
        output.movieGenreList
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let genre):
                    let list = genre.genres
                    self?.movieGenreList.accept(list)
//                    self?.updatePosterImage()
                case .failure(let error):
                    print("movie장르 바인딩 실패: \(error)")
                }
            })
            .disposed(by: disposeBag)
        
        output.tvGenreList
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let genre):
                    let list = genre.genres
                    self?.tvGenreList.accept(list)
//                    self?.updatePosterImage()
                case .failure(let error):
                    print("movie장르 바인딩 실패: \(error)")
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
        mainPosterMedia.onNext(randomMedia)
        let URL =
        APIURL.makeTMDBImageURL(path: posterPath)
        self.rootView.posterImageView.kf.setImage(with: URL)
        self.rootView.posterImageView.contentMode = .scaleAspectFill
        
    }
    
    private func updatePosterGenre() {
        let combinedList = movieGenreList.value + tvGenreList.value
        let selectedPosterGenre = mainPosterMedia.map({ $0.genre_ids })
        
        let genreDictionary = Dictionary(uniqueKeysWithValues: combinedList.map { ($0.id, $0.name) })
        let name = selectedPosterGenre.map { genreIds in
            genreIds.compactMap { genreDictionary[$0] }
        }
        
        
    }
    
    func updateGenreLabel(with combinedList: [Genre], selectedPosterGenre: [Int]) {
           let genreDictionary = Dictionary(uniqueKeysWithValues: combinedList.map { ($0.id, $0.name) })
           let genreNames = selectedPosterGenre.compactMap { genreDictionary[$0] }
           let genreText = genreNames.joined(separator: " / ")
            self.rootView.genreLabel.text = genreText
       }
}
