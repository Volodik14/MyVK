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
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllGroupsController") as? AllGroupsController {
            viewController.groupDelegate = self
            viewController.userGroups = groups
            view.navigationController?.pushViewController(viewController, animated: true)
        }
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
