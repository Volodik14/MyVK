//
//  FriendsModuleRouter.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation
import UIKit

class FriendsModuleRouter {
    var friendPhotosModule: FriendPhotosModuleModuleInput?
}

// MARK: - FriendsModuleRouterInput
extension FriendsModuleRouter: FriendsModuleRouterInput {
    func showFriendPhotosViewController(sender: UIViewController, id: String) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FriendPhotosController") as? FriendPhotosController {
            viewController.userId = id
            sender.navigationController?.pushViewController(viewController, animated: true)
           }
    }
}
