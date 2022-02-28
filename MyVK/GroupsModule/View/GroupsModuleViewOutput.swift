//
//  GroupsModuleViewOutput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

protocol GroupsModuleViewOutput: AnyObject {
    func viewIsReady()
    func plusButtonClicked(view: UIViewController)
}
