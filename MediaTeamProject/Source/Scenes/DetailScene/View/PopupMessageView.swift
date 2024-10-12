//
//  PopupMessageView.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/12/24.
//

import UIKit
import SnapKit

final class PopupMessageView: BaseView {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.black.withAlphaComponent(0.9)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let checkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("확인", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        btn.backgroundColor = AppColor.red
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 5
        btn.tintColor = .white
        return btn
    }()
    
    override func configureHierarchy() {
        addSubview(backView)
        backView.addSubview(messageLabel)
        backView.addSubview(checkButton)
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(15)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(30)
            make.height.equalTo(34)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}

