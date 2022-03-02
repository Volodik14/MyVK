//
//  GroupsModuleRouterInput.swift
//  MyVK
//
//  Created by Владимир Моторкин on 02.03.2022.
//

import Foundation
import UIKit

protocol GroupsModuleRouterInput: AnyObject {
    func showAllGroupsModule(output: AllGroupsModuleModuleOutput, sender: UIViewController, groups: [Group])
}
