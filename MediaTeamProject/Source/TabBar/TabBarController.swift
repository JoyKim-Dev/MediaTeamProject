//
//  TabBarController.swift
//  MediaTeamProject
//
//  Created by 전준영 on 10/9/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = AppColor.white
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = AppColor.blackRussian
        
        enum TabBase: Int, CaseIterable {
            case home, topSearch, download
            
            var title: String {
                switch self {
                case .home:
                    return AppStrings.TabBar.home
                case .topSearch:
                    return AppStrings.TabBar.topSearch
                case .download:
                    return AppStrings.TabBar.download
                }
            }
            
            var image: UIImage? {
                switch self {
                case .home:
                    return AppIcon.house
                case .topSearch:
                    return AppIcon.magnifyingGlass
                case .download:
                    return AppIcon.faceSmiling
                }
            }
            
            var viewController: UIViewController {
                switch self {
                case .home:
                    return HomeViewController()
                case .topSearch:
                    return SearchViewController()
                case .download:
                    return SearchViewController()
                }
            }
        }
        
        let vc = TabBase.allCases.map { tabView in
            let navItem = UINavigationController(rootViewController: tabView.viewController)
            navItem.tabBarItem = UITabBarItem(title: tabView.title, image: tabView.image, tag: tabView.rawValue)
            return navItem
        }
        
        setViewControllers(vc, animated: true)
    }
}
