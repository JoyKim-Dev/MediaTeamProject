//
//  HomeView.swift
//  MediaTeamProject
//
//  Created by Joy Kim on 10/9/24.
//

import UIKit
import SnapKit

final class HomeView: BaseView {
    
    let scrollView =  UIScrollView()
    private let contentView = UIView()
    
    lazy var posterImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let genreLabel = {
        let label = UILabel()
        label.text = "test"
        return label
    }()
    
    private let playButton = {
        let button = UIButton.Configuration.roundCornerButton(title: AppStrings.ButtonTitle.play, backgroundColor: .myAppWhite, foregroundColor: .myAppBlack, appIcon: AppIcon.play!)
        return button
    }()
    
    private let likeButton = {
        let button = UIButton.Configuration.roundCornerButton(title: AppStrings.ButtonTitle.addToList, backgroundColor: .myAppBlack, foregroundColor: .myAppWhite, appIcon: AppIcon.plus!)
        return button
    }()
    
    private lazy var buttonStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private let movieTableViewHeader = {
        let label = UILabel()
        label.text = "지금 뜨는 영화"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .myAppWhite
        label.textAlignment = .left
        return label
    }()
    
    private let tvTableViewHeader = {
        let label = UILabel()
        label.text = "지금 뜨는 TV 시리즈"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .myAppWhite
        return label
    }()
    
    lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    lazy var tvCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(genreLabel)
        contentView.addSubview(buttonStack)
        buttonStack.addArrangedSubview(playButton)
        buttonStack.addArrangedSubview(likeButton)
        contentView.addSubview(movieCollectionView)
        contentView.addSubview(tvCollectionView)
        contentView.addSubview(movieTableViewHeader)
        contentView.addSubview(tvTableViewHeader)
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
            make.top.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(700)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.centerX.equalTo(posterImageView)
            make.bottom.equalTo(buttonStack.snp.top).offset(-15)
        }
        buttonStack.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(posterImageView).inset(10)
            make.height.equalTo(30)
            make.bottom.equalTo(posterImageView.snp.bottom).inset(10)
        }
        
        playButton.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        likeButton.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        movieTableViewHeader.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
        
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(movieTableViewHeader.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(140)
        }
        
        tvTableViewHeader.snp.makeConstraints { make in
            make.top.equalTo(movieCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
        
        tvCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tvTableViewHeader.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(140)
            make.bottom.equalTo(contentView).inset(10)
        }
        
        
    }
    
    override func configureView() {
        
    }
}

extension HomeView {
    func setupCollectionView() {
        movieCollectionView.register(MediaPosterCell.self, forCellWithReuseIdentifier: MediaPosterCell.identifier)
        movieCollectionView.showsHorizontalScrollIndicator = false
        movieCollectionView.backgroundColor = .clear
        tvCollectionView.register(MediaPosterCell.self, forCellWithReuseIdentifier: MediaPosterCell.identifier)
        tvCollectionView.showsHorizontalScrollIndicator = false
        tvCollectionView.backgroundColor = .clear
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 20
        layout.itemSize = CGSize(width: width / 4.5, height: width / 1.5)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        return layout
    }
    
}

