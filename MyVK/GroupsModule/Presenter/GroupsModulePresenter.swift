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
    weak var output: GroupsModuleModuleOutput?
    var interactor: GroupsModuleInteractorInput!
    var router: GroupsModuleRouterInput!

    private var closeView: (() -> ())?
    private var closeImage: UIImage?
}

// MARK: - Present
extension GroupsModulePresenter {
    func present(from vc: UIViewController) {
    }

    func presentAsNavController(from vc: UIViewController) {
    }
}


// MARK: - GroupsModuleViewOutput
extension GroupsModulePresenter: GroupsModuleViewOutput {
    func plusButtonClicked(view: UIViewController) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllGroupsController") as? AllGroupsController {
            viewController.groupDelegate = self
            view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func viewIsReady() {
        interactor.getGroupsList()
    }
    
    func getGroupsListSuccess(model: [Group]) {
        view.updateData(groups: model)
    }
    
    func getGroupsListFail(error: String) {
        print(error)
    }
}

// MARK: - GroupsModuleViewOutput
extension GroupsModulePresenter: AddGroupDelegate {
    func setGroup(group: Group) {
        view.addGroup(group: group)
    }
}


// MARK: - GroupsModuleInteractorOutput
extension GroupsModulePresenter: GroupsModuleInteractorOutput {

}
