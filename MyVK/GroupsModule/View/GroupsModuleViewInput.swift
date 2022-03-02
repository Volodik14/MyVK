//
//  GroupsModuleViewInput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

protocol GroupsModuleViewInput: AnyObject {
    var output: GroupsModuleViewOutput? { get set }
    func updateData()
}
