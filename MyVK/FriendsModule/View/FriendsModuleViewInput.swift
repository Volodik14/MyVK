//
//  FriendsModuleViewInput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

protocol FriendsModuleViewInput: AnyObject {
    var output: FriendsModuleViewOutput? { get set }
    func updateData()
}

