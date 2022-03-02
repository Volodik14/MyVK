//
//  GroupsModulePresenter.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

protocol AddGroupDelegate {
    func setGroup(group: Group)
}

class GroupsModulePresenter {
    weak var view: GroupsModuleViewInput!
    var interactor: GroupsModuleInteractorInput!
    var router: GroupsModuleRouterInput!
    var groups = [Group]()
}



// MARK: - GroupsModuleViewOutput
extension GroupsModulePresenter: GroupsModuleViewOutput {
    var itemsCount: Int {
        groups.count
    }
    
    func getItem(row: Int) -> Group {
        groups[row]
    }
    
    func plusButtonClicked(view: UIViewController) {
        router.showAllGroupsModule(output: self, sender: view, groups: groups)
    }
    
    func viewIsReady() {
        interactor.getGroupsList()
    }
    
    func getGroupsListSuccess(model: [Group]) {
        self.groups = model
        view.updateData()
    }
    
    func getGroupsListFail(error: String) {
        print(error)
    }
}

// MARK: - GroupsModuleViewOutput
extension GroupsModulePresenter: AddGroupDelegate {
    func setGroup(group: Group) {
        groups.append(group)
        view.updateData()
    }
}


// MARK: - GroupsModuleInteractorOutput
extension GroupsModulePresenter: GroupsModuleInteractorOutput {

}

extension GroupsModulePresenter: AllGroupsModuleModuleOutput {
    func addGroup(group: Group) {
        groups.append(group)
        view.updateData()
    }
}
