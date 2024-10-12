//
//  CircleBackgroundIconButton.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/11/24.
//

import UIKit

extension UIButton {
    
    static func backgroundIconButton(icon: UIImage?, iconSize: CGFloat) -> UIButton {
        let button: UIButton = {
            let btn = UIButton(type: .system)
            btn.setImage(icon?.applyingSymbolConfiguration(.init(pointSize: iconSize)), for: .normal)
            btn.tintColor = .white
            btn.layer.backgroundColor = AppColor.blackRussian.withAlphaComponent(0.6).cgColor
            btn.clipsToBounds = true
            btn.isUserInteractionEnabled = true
            return btn
        }()
        
        return button
    }
}
