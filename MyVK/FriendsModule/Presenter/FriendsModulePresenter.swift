//
//  FriendsModulePresenter.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendsModulePresenter {
    weak var view: FriendsModuleViewInput!
    //weak var output: FriendsModuleModuleOutput?
    var interactor: FriendsModuleInteractorInput!
    var router: FriendsModuleRouterInput!

    private var closeView: (() -> ())?
    private var closeImage: UIImage?
}

// MARK: - Present
/*
extension FriendsModulePresenter {
    func present(from vc: UIViewController) {
        closeImage = UIImage(named: "back_arrow_black")
        closeView = { [weak self] in
            self?.view.viewController.navigationController?.popViewController(animated: true)
        }
        view.present(from: vc)
    }

    func presentAsNavController(from vc: UIViewController) {
        closeImage = UIImage(named: "close_black")
        closeView = { [weak self] in
            self?.view.viewController.navigationController?.dismiss(animated: true)
        }
        view.presentAsNavController(from: vc)
    }
}
*/

// MARK: - FriendsModuleViewOutput
extension FriendsModulePresenter: FriendsModuleViewOutput {

    func viewIsReady(tableView: UITableView) {
        interactor.getFriendsList()
        interactor.subscribeToChanges(tableView: tableView)
    }
    
}

// MARK: - FriendsModuleInteractorOutput
extension FriendsModulePresenter: FriendsModuleInteractorOutput {
    func subscribeToChangesSuccess() {
        print("Success subscribing")
    }
    
    func subscribeToChangesFail(error: String) {
        print(error)
    }
    
    func getFriendsListSuccess(model: [User]) {
        view.updateData(friends: model)
    }
    
    func getFriendsListFail(error: String) {
        print(error)
    }
}
