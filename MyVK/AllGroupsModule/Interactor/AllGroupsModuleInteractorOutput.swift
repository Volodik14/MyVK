//
//  AllGroupsModuleInteractorOutput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation

protocol AllGroupsModuleInteractorOutput: AnyObject {
    func getAllGroupsSuccess(model: [Group])
    func getAllGroupsFail(error: String)
}
