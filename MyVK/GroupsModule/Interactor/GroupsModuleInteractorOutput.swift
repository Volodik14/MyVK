//
//  GroupsModuleInteractorOutput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation

protocol GroupsModuleInteractorOutput: AnyObject {
    func getGroupsListSuccess(model: [Group])
    func getGroupsListFail(error: String)
}
