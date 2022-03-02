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
    var friends = [User]()
}


// MARK: - FriendsModuleViewOutput
extension FriendsModulePresenter: FriendsModuleViewOutput {
    var itemsCount: Int {
        friends.count
    }
    
    func getItem(row: Int) -> User {
        friends[row]
    }
    
    func showFriendsPhoto(sender: UIViewController, row: Int) {
        router.showFriendPhotosViewController(sender: sender, id: friends[row].id)
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
        self.friends = model
        view.updateData()
    }
    
    func getFriendsListFail(error: String) {
        print(error)
    }
}
