//
//  GroupsModuleModuleInput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

protocol GroupsModuleModuleInput: AnyObject {
    func present(from viewController: UIViewController)
    func presentAsNavController(from vc: UIViewController)
}
