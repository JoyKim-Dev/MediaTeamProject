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
        label.font = .boldSystemFont(ofSize: 17)
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
    
    let noDataLabel: UILabel = {
        let label = UILabel()
        
        let attribute = NSMutableAttributedString(string: "아직 저장된 미디어 없습니다\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 17)
        ])
        attribute.append(NSAttributedString(string: "좋아하는 미디어를 추가해 보세요 🎬", attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]))
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        attribute.addAttribute(.paragraphStyle,
                               value: style,
                               range: NSRange(location: 0, length: attribute.length))
        
        label.attributedText = attribute
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(headerTitle)
        addSubview(tableView)
        addSubview(noDataLabel)
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
        
        noDataLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
