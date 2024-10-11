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
        view.register(MediaBackdropTableViewCell.self, forCellReuseIdentifier: MediaBackdropTableViewCell.identifier)
        view.rowHeight = 150
        view.separatorStyle = .none
        return view
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.register(MediaPosterCell.self, forCellWithReuseIdentifier: MediaPosterCell.identifier)
        collectionView.backgroundColor = .myAppBlack
        return collectionView
    }()
    
    static private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 2
        let cellSpacing: CGFloat = 2
        let numberOfItemsPerRow: CGFloat = 3
        let availableWidth = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * (numberOfItemsPerRow - 1))
        let cellWidth = availableWidth / numberOfItemsPerRow
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.6)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(genreView)
        genreView.addSubview(genreLabel)
        addSubview(recommendTableView)
        addSubview(collectionView)
        
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
        
        collectionView.snp.makeConstraints { make in
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
            collectionView.isHidden = true
            genreLabel.text = "추천 시리즈 & 영화"
        } else {
            collectionView.isHidden = false
            genreLabel.text = "영화 & 시리즈"
        }
    }
    
}
