//
//  SearchTableViewCell.swift
//  MediaTeamProject
//
//  Created by 전준영 on 10/10/24.
//

import UIKit
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let playImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcon.play
        return imageView
    }()
    
    override func configureHierarchy() {
        addSubview(posterImage)
        addSubview(title)
        addSubview(playImage)
    }
    
    override func configureLayout() {
        posterImage.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.width.equalTo(150)
        }
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(posterImage.snp.trailing).offset(10)
            make.centerY.equalTo(posterImage)
        }
        
        playImage.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).inset(10)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
