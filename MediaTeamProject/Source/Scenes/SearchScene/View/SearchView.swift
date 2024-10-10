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
    
    private let genreView = UIView()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 시리즈 & 영화"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .myAppWhite
        return label
    }()
    
    let recommendTableView: UITableView = {
        let view = UITableView()
        view.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.identifier)
        view.rowHeight = 150
        view.separatorStyle = .none
        return view
    }()
    
    let pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageVC
    }()
    
    override func configureHierarchy() {
        addSubview(genreView)
        genreView.addSubview(genreLabel)
        addSubview(recommendTableView)
        addSubview(pageViewController.view)
        searchBar.delegate = self
    }
    
    override func configureLayout() {
        genreView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(genreView)
            make.leading.equalTo(safeAreaLayoutGuide).inset(15)
        }
        
        recommendTableView.snp.makeConstraints { make in
            make.top.equalTo(genreView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(genreView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
        recommendTableView.backgroundColor = .myAppBlack
    }
    
}

extension SearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            pageViewController.view.isHidden = true
            let defaultPage = comeBackVC()
            pageViewController.setViewControllers([defaultPage], direction: .reverse, animated: false, completion: nil)
        } else {
            pageViewController.view.isHidden = false
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
