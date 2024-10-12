//
//  RoundCornerButton.swift
//  MediaTeamProject
//
//  Created by Joy Kim on 10/9/24.
//

import UIKit

extension UIButton.Configuration {
    
    static func roundCornerButton(title: String, backgroundColor: UIColor, foregroundColor: UIColor, appIcon: UIImage) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .medium
        configuration.title = title
        configuration.attributedTitle?.font = .caption2
        configuration.imagePadding = 2
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        configuration.imagePlacement = .leading
        configuration.baseBackgroundColor = backgroundColor
        configuration.baseForegroundColor = foregroundColor
        configuration.image = appIcon
        configuration.imagePadding = 5
        configuration.titlePadding = 2
        let button = UIButton(configuration: configuration)
        return button
    }
}

