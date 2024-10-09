//
//  SearchView.swift
//  MediaTeamProject
//
//  Created by 전준영 on 10/9/24.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    private let testLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    override func configureHierarchy() {
        addSubview(testLabel)
    }
    
    override func configureLayout() {
        testLabel.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
