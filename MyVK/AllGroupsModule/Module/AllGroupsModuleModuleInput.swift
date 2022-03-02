//
//  AllGroupsModuleModuleInput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

protocol AllGroupsModuleModuleInput: AnyObject {
    func present(from viewController: UIViewController)
    func presentAsNavController(from vc: UIViewController)
}