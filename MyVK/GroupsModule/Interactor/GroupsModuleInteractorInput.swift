//
//  GroupsModuleInteractorInput.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation

protocol GroupsModuleInteractorInput: AnyObject {
    var output: GroupsModuleInteractorOutput? { get set }
    func getGroupsList()
}