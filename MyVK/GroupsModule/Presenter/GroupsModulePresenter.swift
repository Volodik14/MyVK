//
//  GroupsModulePresenter.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

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


// MARK: - GroupsModuleInteractorOutput
extension GroupsModulePresenter: GroupsModuleInteractorOutput {

}
