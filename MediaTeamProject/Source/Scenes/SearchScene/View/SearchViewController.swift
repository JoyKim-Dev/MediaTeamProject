//
//  SearchViewController.swift
//  MediaTeamProject
//
//  Created by 전준영 on 10/9/24.
//

import UIKit

final class SearchViewController: BaseViewController<SearchView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchNaviConfigure()
    }
    
}

extension SearchViewController {
    
    private func searchNaviConfigure() {
        navigationItem.titleView = rootView.searchBar
    }
    
}
