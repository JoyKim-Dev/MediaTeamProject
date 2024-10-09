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

final class MediaPosterCell: BaseCollectionViewCell {
    
    let moviePosterImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(moviePosterImageView)
    }
    
    override func configureLayout()  {
        moviePosterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
    }
}

extension MediaPosterCell {
    
// APIModel 업데이트 되면 반영
     func configUI() {

    }
}

