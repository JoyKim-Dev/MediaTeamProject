//
//  HomeView.swift
//  MediaTeamProject
//
//  Created by Joy Kim on 10/9/24.
//

import UIKit
import SnapKit

final class HomeView: BaseView {
    
    private let scrollView =  UIScrollView()
    private let contentView = UIView()
    
    private let posterImageView = {
        let imageView = UIImageView()
        imageView.image = .checkmark
        return imageView
    }()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(collectionView)
    }
    
    override func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.height.width.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(contentView).inset(10)
        
        }
    }
    private func collectionViewLayout() -> UICollectionViewLayout {
        
        print(#function)
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width / 3, height: width / 2.5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    }
}

