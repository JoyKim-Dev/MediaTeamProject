//
//  TrendTableViewCell.swift
//  MediaTeamProject
//
//  Created by 전준영 on 10/10/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift

final class TrendTableViewCell: BaseTableViewCell {
    
    var disposeBag = DisposeBag()
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .myAppWhite
        return label
    }()
    
    private let playImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcon.playCircle?.withTintColor(.myAppWhite, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureHierarchy() {
        addSubview(posterImage)
        addSubview(title)
        addSubview(playImage)
    }
    
    override func configureLayout() {
        posterImage.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(safeAreaLayoutGuide).inset(5)
            make.width.equalTo(150)
        }
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(posterImage.snp.trailing).offset(10)
            make.centerY.equalTo(posterImage)
        }
        
        playImage.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(10)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        backgroundColor = .myAppBlack
        posterImage.backgroundColor = .green
    }
}

//MARK: Search
extension TrendTableViewCell {
    
    func searchConfigure(_ movieData: Media) {
        if let url = movieData.poster_path {
            let URL = URL(string: "https://image.tmdb.org/t/p/w780\(url)")
            posterImage.kf.setImage(with: URL)
//            posterImage.contentMode = .scaleAspectFit
        } else {
            posterImage.image = UIImage(systemName: "star")
        }
        
        title.text = movieData.mediaTitle
        
    }
    
}
