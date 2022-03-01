//
//  TabBarModuleViewController.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class TabBarModuleViewController: UITabBarController {
    
    @IBOutlet private var navigationView: UIView!
    @IBOutlet private var navigationViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        let friendsModule = FriendsModuleModule()
        let friendsController = friendsModule.configuredFiewController()
        
        let groupsModule = GroupsModuleModule()
        let groupsController = groupsModule.configuredFiewController()
        
        viewControllers = [
            generateNavigationController(rootViewController: friendsController, unselectedImage: UIImage(systemName: "person.fill"), selectedImage: UIImage(systemName: "person.fill"), title: "Друзья"),
            generateNavigationController(rootViewController: groupsController, unselectedImage: UIImage(systemName: "person.3.fill"), selectedImage: UIImage(systemName: "person.3.fill"), title: "Группы")
        ]
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsfeedController") as? NewsfeedController {
            viewControllers?.append(generateNavigationController(rootViewController: viewController, unselectedImage: UIImage(systemName: "newspaper.fill"), selectedImage: UIImage(systemName: "newspaper.fill"), title: "Новости"))
        }
        
    }
    
    private func generateNavigationController(rootViewController: UIViewController, unselectedImage: UIImage?, selectedImage: UIImage?, title: String?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.setNavigationBarHidden(false, animated: true)
        navigationVC.tabBarItem.image = unselectedImage
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.selectedImage = selectedImage
        navigationVC.navigationBar.isTranslucent = true
        return navigationVC
    }
    
}


// MARK: - Creation
extension TabBarModuleViewController: TabBarModuleViewInput {
    static func create() -> TabBarModuleViewController {
        let view = TabBarModuleViewController()
        return view
    }
}

