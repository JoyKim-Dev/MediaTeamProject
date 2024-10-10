//
//  MediaPosterCell.swift
//  MediaTeamProject
//
//  Created by Joy Kim on 10/9/24.
//

import UIKit

import Alamofire
import SnapKit
import Kingfisher
import RxSwift

final class MediaPosterCell: BaseCollectionViewCell {
    var disposeBag = DisposeBag()
    
    let moviePosterImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(moviePosterImageView)
    }
    
    override func configureLayout()  {
        moviePosterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension MediaPosterCell {
    
    func configUI(data: Media) {
        
        moviePosterImageView.clipsToBounds = true
        moviePosterImageView.layer.cornerRadius = 5
        
        if let url = data.poster_path {
            let URL =
            APIURL.makeTMDBImageURL(path: url)
            moviePosterImageView.kf.setImage(with: URL)
            moviePosterImageView.contentMode = .scaleAspectFit
        } else {
            moviePosterImageView.image = UIImage(systemName: "star")
        }
    }
}

