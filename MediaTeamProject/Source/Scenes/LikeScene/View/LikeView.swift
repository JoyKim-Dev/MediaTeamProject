//
//  LikeView.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/10/24.
//

import UIKit
import SnapKit

final class LikeView: BaseView {
    
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "영화 시리즈"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(MediaBackdropTableViewCell.self, forCellReuseIdentifier: MediaBackdropTableViewCell.identifier)
        tv.rowHeight = 150
        tv.separatorStyle = .none
        tv.backgroundColor = AppColor.black
        return tv
    }()
    
    override func configureHierarchy() {
        addSubview(headerTitle)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        headerTitle.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().inset(2)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
