//
//  AllGroupsModulePresenter.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class AllGroupsModulePresenter {
    weak var view: AllGroupsModuleViewInput!
    weak var output: AllGroupsModuleModuleOutput?
    var interactor: AllGroupsModuleInteractorInput!
    var router: AllGroupsModuleRouterInput!

    private var groups = [Group]()
    var userGroups = [Group]()
}

// MARK: - Present
extension AllGroupsModulePresenter {
    func present(from vc: UIViewController) {
        view.present(from: vc)
    }
}

// MARK: - AllGroupsModuleViewOutput
extension AllGroupsModulePresenter: AllGroupsModuleViewOutput {
    var itemsCount: Int {
        groups.count
    }
    
    func getItem(row: Int) -> Group {
        groups[row]
    }
    
    func addGroup(sender: UIViewController, row: Int) {
        router.closeView(sender: sender)
        output?.addGroup(group: groups[row])
    }
    
    func viewIsReady() {
        
    }
    
    func getGroups(search: String) {
        interactor.getAllGroups(search: search, userGroups: userGroups)
    }
}

// MARK: - AllGroupsModuleInteractorOutput
extension AllGroupsModulePresenter: AllGroupsModuleInteractorOutput {
    func getAllGroupsSuccess(model: [Group]) {
        self.groups = model
        view.updateData()
    }
    
    func getAllGroupsFail(error: String) {
        print(error)
    }
}
