//
//  AllGroupsModuleRouter.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation
import UIKit

class AllGroupsModuleRouter {

}

// MARK: - AllGroupsModuleRouterInput
extension AllGroupsModuleRouter: AllGroupsModuleRouterInput {
    func closeView(sender: UIViewController) {
        sender.navigationController?.popViewController(animated: true)
    }
}
