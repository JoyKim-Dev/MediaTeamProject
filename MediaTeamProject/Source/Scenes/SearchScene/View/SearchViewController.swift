//
//  SearchViewController.swift
//  MediaTeamProject
//
//  Created by 전준영 on 10/9/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController<SearchView> {
    
    private let viewModel = SearchViewModel()
    private var isSearchEmpty = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchNaviConfigure()
    }
    
    override func configureView() {
        rootView.collectionView.isHidden = true
    }
    
    override func bindModel() {
        let input = SearchViewModel.Input(
            searchText: rootView.searchBar.rx.text.orEmpty.asObservable(),
            loadMoreTrigger: rootView.collectionView.rx.reachedBottom(offset: 100).asObservable())
        let output = viewModel.transform(input: input)
        
        //추천시리즈
        output.trendList
            .bind(to: rootView.recommendTableView.rx.items(
                cellIdentifier: MediaBackdropTableViewCell.identifier,
                cellType: MediaBackdropTableViewCell.self)) { row, item, cell in
                    cell.searchConfigure(item)
                }
                .disposed(by: viewModel.disposeBag)
        
        //검색결과
        output.searchResult
            .bind(to: rootView.collectionView.rx.items(
                cellIdentifier: MediaPosterCell.identifier,
                cellType: MediaPosterCell.self)) { row, item, cell in
                    cell.configUI(data: item)
                }
                .disposed(by: viewModel.disposeBag)
        
        Observable.zip(
            rootView.recommendTableView.rx.modelSelected(Media.self),
            rootView.recommendTableView.rx.itemSelected
        )
        .bind(with: self, onNext: { owner, data in
            let (selectedMedia, indexPath) = data
            let detailViewModel = DetailViewModel(media: selectedMedia)
            let detailVC = DetailViewController(viewModel: detailViewModel)
            owner.present(detailVC, animated: true)
            owner.rootView.recommendTableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: viewModel.disposeBag)
        
        Observable.zip(
            rootView.collectionView.rx.modelSelected(Media.self),
            rootView.collectionView.rx.itemSelected
        )
        .bind(with: self, onNext: { owner, data in
            let (selectedMedia, indexPath) = data
            let detailViewModel = DetailViewModel(media: selectedMedia)
            let detailVC = DetailViewController(viewModel: detailViewModel)
            owner.present(detailVC, animated: true)
            owner.rootView.recommendTableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: viewModel.disposeBag)
        
    }
    
}

//MARK: - ViewSet
extension SearchViewController {
    
    private func searchNaviConfigure() {
        navigationItem.titleView = rootView.searchBar
    }
    
}
