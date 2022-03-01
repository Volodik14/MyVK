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

}


// MARK: - FriendsModuleViewOutput
extension FriendsModulePresenter: FriendsModuleViewOutput {
    func showFriendsPhoto(sender: UIViewController, friend: User) {
        router.showFriendPhotosViewController(sender: sender, id: friend.id)
    }
    
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
