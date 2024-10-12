//
//  DetailView.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/11/24.
//

import UIKit
import SnapKit

final class DetailView: BaseView {
    
    let backdropImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let tvCircleButton = UIButton.backgroundIconButton(icon: AppIcon.sparklesTV, iconSize: 10)
    let xCircleButton = UIButton.backgroundIconButton(icon: AppIcon.xmark, iconSize: 10)
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    let mediaNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    lazy var playButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(AppIcon.play?.applyingSymbolConfiguration(.init(pointSize: 11)), for: .normal)
        btn.setTitle("  재생", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.backgroundColor = .white
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 5
        btn.tintColor = .black
        btn.tag = 0
        btn.addTarget(self, action: #selector(didTouchDown), for: .touchDown)
        btn.addTarget(self, action: #selector(didTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        return btn
    }()
    
    lazy var saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(AppIcon.download?.applyingSymbolConfiguration(.init(pointSize: 11)), for: .normal)
        btn.setTitle("  저장", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.backgroundColor = AppColor.blackRussian
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 5
        btn.tintColor = .white
        btn.tag = 1
        btn.addTarget(self, action: #selector(didTouchDown), for: .touchDown)
        btn.addTarget(self, action: #selector(didTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        return btn
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    let actingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let directingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let similarTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "비슷한 콘텐츠"
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.register(MediaPosterCell.self, forCellWithReuseIdentifier: MediaPosterCell.identifier)
        collectionView.backgroundColor = .myAppBlack        
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    static private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 2
        let cellSpacing: CGFloat = 2
        let numberOfItemsPerRow: CGFloat = 3
        let availableWidth = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * (numberOfItemsPerRow - 1)) - 30
        let cellWidth = availableWidth / numberOfItemsPerRow
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.6)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(backdropImageView)
        addSubview(xCircleButton)
        addSubview(tvCircleButton)
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(mediaNameLabel)
        containerView.addSubview(voteAverageLabel)
        containerView.addSubview(playButton)
        containerView.addSubview(saveButton)
        containerView.addSubview(overviewLabel)
        containerView.addSubview(actingLabel)
        containerView.addSubview(directingLabel)
        containerView.addSubview(similarTitleLabel)
        containerView.addSubview(collectionView)
    }
    
    override func configureLayout() {
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(backdropImageView.snp.width).multipliedBy(0.6)
        }
        
        xCircleButton.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.top).offset(15)
            make.trailing.equalTo(backdropImageView.snp.trailing).offset(-15)
            make.size.equalTo(22)
        }
        
        tvCircleButton.snp.makeConstraints { make in
            make.top.equalTo(xCircleButton)
            make.trailing.equalTo(xCircleButton.snp.leading).offset(-12)
            make.size.equalTo(22)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        mediaNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        voteAverageLabel.snp.makeConstraints { make in
            make.top.equalTo(mediaNameLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(10)
        }
        
        playButton.snp.makeConstraints { make in
            make.top.equalTo(voteAverageLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(37)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(37)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        actingLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().offset(10)
        }
        
        directingLabel.snp.makeConstraints { make in
            make.top.equalTo(actingLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().offset(10)
        }
        
        similarTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(directingLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(similarTitleLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(500)
            make.bottom.equalToSuperview().offset(-5)
        }
    
    }
    
    override func configureView() {
        tvCircleButton.layer.cornerRadius = 22/2
        xCircleButton.layer.cornerRadius = 22/2
    }
}

extension DetailView {
    //버튼 탭 유지할 때
    @objc func didTouchDown(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            //play 버튼
            sender.backgroundColor = .white.withAlphaComponent(0.8)
        
        case 1:
            //save 버튼
            sender.backgroundColor = .darkGray.withAlphaComponent(0.5)
        default: break
        }
    }
    
    //버튼 탭 해제할 때
    @objc func didTouchUp(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            //play 버튼
            sender.backgroundColor = .white
            
        case 1:
            //save 버튼
            sender.backgroundColor = AppColor.blackRussian
        default: break
        }
    }
}
