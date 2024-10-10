//
//  SearchView.swift
//  MediaTeamProject
//
//  Created by 전준영 on 10/9/24.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "게임, 시리즈, 영화를 검색하세요.."
        searchBar.barTintColor = .myAppWhite
        searchBar.showsCancelButton = false
        
        if let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchBarTextField.backgroundColor = .myAppBlackRussian
            searchBarTextField.textColor = .myAppWhite
            searchBarTextField.tintColor = .myAppWhite
            
            let placeholderText = searchBarTextField.placeholder ?? ""
            searchBarTextField.attributedPlaceholder = NSAttributedString(
                string: placeholderText,
                attributes: [.foregroundColor: UIColor.lightGray]
            )
        }
        
        return searchBar
    }()
    
    let recommendTableView: UITableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        view.rowHeight = 400
        view.separatorStyle = .none
        return view
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageVC
    }()
    
    override func configureHierarchy() {
        addSubview(pageViewController.view)
        
        searchBar.delegate = self
    }
    
    override func configureLayout() {
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
    
}

extension SearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            let defaultPage = comeBackVC()
            pageViewController.setViewControllers([defaultPage], direction: .reverse, animated: false, completion: nil)
        } else {
            let resultPage = searchingVC(searchText)
            pageViewController.setViewControllers([resultPage], direction: .forward, animated: false, completion: nil)
        }
    }
    
    private func comeBackVC() -> UIViewController {
        let defaultVC = SearchViewController()
        return defaultVC
    }
    
    private func searchingVC(_ searchText: String) -> UIViewController {
        let resultVC = SearchResultViewController()
        resultVC.q = searchText
        return resultVC
    }
}

final class SearchResultViewController: UIViewController {
    var q: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}
