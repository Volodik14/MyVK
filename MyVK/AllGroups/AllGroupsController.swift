//
//  AllGroupsController.swift
//  MyVK
//
//  Created by Владимир Моторкин on 01.02.2022.
//

import UIKit
import RealmSwift

class AllGroupsController: UITableViewController, UISearchResultsUpdating {
    var userId = ""
    var accessToken = ""
    
    func updateSearchResults(for searchController: UISearchController) {
        // MARK: - Проблема с фильтрацией вывода только групп пользователя.
        let vkService = VKService(userId, accessToken)
        vkService.loadGroupsDataBySearch(search: searchController.searchBar.text!, completion: { [self] searchGroups in
            // Не работает contains...
            //self.groups.removeAll(where: self.userGroups.contains(_:))
            
            let groupsWithoutUserGroups = searchGroups.filter( { (searchGroup) -> Bool in
                for userGroup in userGroups  {
                    if searchGroup == userGroup  {
                        return false
                    }
                }
                return true
            })
            self.groups = groupsWithoutUserGroups
        })
        self.tableView.reloadData()
    }
    
    var groups = [Group]()
    var resultSearchController = UISearchController()
    
    var userGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadData()
        if let userId = UserDefaults.standard.string(forKey: "userId") {
            if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
                self.userId = userId
                self.accessToken = accessToken
            } else {
                print("Cannot get data, cannot get access token!")
            }
        } else {
            print("Cannot get data, cannot get user id!")
        }
        
        // Контроллер поиска групп.
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        tableView.reloadData()
        
    }
    
    // Загрузка данных.
    func loadData() {
        do {
            let realm = try Realm()
            
            let userGroups = realm.objects(Group.self)
            
            self.userGroups = Array(userGroups)
        } catch {
            print(error)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allGroupsCell", for: indexPath) as! AllGroupsCell
        
        let group = groups[indexPath.row]
        
        let groupName = group.name
        let membersCount = group.countMembers
        
        // Асинхронно задаём фото для строки.
        if let groupPhoto = group.photo {
            let url = URL(string: groupPhoto.url)!
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.groupImage.image = UIImage(data: data)
                    }
                }
            }
        } else {
            cell.groupImage.image = UIImage(systemName: "circle")
        }
        
        cell.groupSubsCount.text = membersCount + " участников"
        cell.groupName.text = groupName
        
        return cell
    }
}
