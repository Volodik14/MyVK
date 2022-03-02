//
//  GroupsModuleRouter.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation
import UIKit

class GroupsModuleRouter {
    
}

// MARK: - GroupsModuleRouterInput
extension GroupsModuleRouter: GroupsModuleRouterInput {
    func showAllGroupsModule(output: AllGroupsModuleModuleOutput, sender: UIViewController, groups: [Group]) {
        AllGroupsModuleModule(output: output, userGroups: groups).present(from: sender)
    }
}
