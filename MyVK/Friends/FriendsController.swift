//
//  FriendsController.swift
//  MyVK
//
//  Created by Владимир Моторкин on 01.02.2022.
//

import UIKit
import RealmSwift


import UIKit

class FriendsController: UITableViewController {
    var notificationToken: NotificationToken? = nil
    var friends = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pairTableAndRealm()
    }
    
    //Загрузка данных.
    func loadData() {
        do {
            let realm = try Realm()
            
            let friends = realm.objects(User.self)
            
            self.friends = Array(friends)
        } catch {
            print(error)
        }
    }
    // Перезод на контроллер показа фото.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showFriendPhotos") {
            let friendsPhotosController = (segue.destination as! FriendPhotosController)
            if let row = tableView.indexPathForSelectedRow?.row {
                friendsPhotosController.userId = friends[row].id
            }
            
        }
    }
    
    // Подключение уведомлений Realm и загрузка изначальных данных.
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        
        let friends = realm.objects(User.self)
        self.friends = Array(friends)
        print(self.friends.count)
        
        notificationToken = friends.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
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
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        let friend = friends[indexPath.row]
        cell.config(with: friend)
        
        return cell
    }
    
    
}
