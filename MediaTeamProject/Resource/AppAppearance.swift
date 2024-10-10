//
//  AppAppearance.swift
//  MediaTeamProject
//
//  Created by Joy Kim on 10/10/24.
//

import UIKit

final class AppAppearance {
    static func setupAppearance() {
        
        let navBarAppearance = UINavigationBarAppearance()
        let tapBarAppearance = UITabBarAppearance()
        let labelTextAppearnce = UILabel.appearance()
        
        
        navBarAppearance.backgroundColor = .myAppBlack
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.myAppWhite]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
        tapBarAppearance.backgroundColor = .myAppBlackRussian
        UITabBar.appearance().scrollEdgeAppearance = tapBarAppearance
        UITabBar.appearance().standardAppearance = tapBarAppearance
        
        labelTextAppearnce.textColor = .myAppWhite
    }
}
