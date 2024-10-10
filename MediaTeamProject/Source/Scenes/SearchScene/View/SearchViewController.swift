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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchNaviConfigure()
        
        rootView.pageViewController.view.isHidden = true
    }
    
    override func bindModel() {
        let input = SearchViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.trendList
            .bind(with: self) { owner, trendResult in
                print(trendResult)
            }
            .disposed(by: viewModel.disposeBag)
        
        
        output.trendList
            .bind(to: rootView.recommendTableView.rx.items(
                cellIdentifier: TrendTableViewCell.identifier,
                cellType: TrendTableViewCell.self)) { row, item, cell in
                    cell.searchConfigure(item)
                    
                }
                .disposed(by: viewModel.disposeBag)
    }
    
}

extension SearchViewController {
    
    private func searchNaviConfigure() {
        navigationItem.titleView = rootView.searchBar
    }
    
}
