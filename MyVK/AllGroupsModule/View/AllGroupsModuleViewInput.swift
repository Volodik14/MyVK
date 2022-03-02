//
//  AllGroupsModuleViewInput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

protocol AllGroupsModuleViewInput: AnyObject, Presentable, Loadable {
    var output: AllGroupsModuleViewOutput? { get set }

    func setupNavigationBar(title: String, leftButtonImage: UIImage?)
}