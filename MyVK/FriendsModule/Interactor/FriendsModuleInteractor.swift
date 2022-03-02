//
//  FriendsModuleInteractor.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class FriendsModuleInteractor {
    weak var output: FriendsModuleInteractorOutput?
    private var notificationToken: NotificationToken? = nil
}

// MARK: - FriendsModuleInteractorInput
extension FriendsModuleInteractor: FriendsModuleInteractorInput {
    // Получает список друзей из Realm.
    func getFriendsList() {
        guard let realm = try? Realm() else { return }
        
        let friends = Array(realm.objects(User.self))
        
        output?.getFriendsListSuccess(model: friends)
        
    }
    
    // Подписка на обновления в Realm для TableView.
    func subscribeToChanges(tableView: UITableView) {
        guard let realm = try? Realm() else { return }
        
        let friends = realm.objects(User.self)
        
        notificationToken = friends.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    
}
