//
//  AllGroupsModuleInteractorInput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation

protocol AllGroupsModuleInteractorInput: AnyObject {
    var output: AllGroupsModuleInteractorOutput? { get set }
    func getAllGroups(search: String, userGroups: [Group])
}
