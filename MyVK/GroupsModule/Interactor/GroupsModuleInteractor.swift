//
//  GroupsModuleInteractor.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation
import RealmSwift

class GroupsModuleInteractor {
    weak var output: GroupsModuleInteractorOutput?
}

// MARK: - GroupsModuleInteractorInput
extension GroupsModuleInteractor: GroupsModuleInteractorInput {
    func getGroupsList() {
        
        guard let realm = try? Realm() else { return }
        
        let groups = Array(realm.objects(Group.self))
        
        output?.getGroupsListSuccess(model: groups)
        
    }
}
