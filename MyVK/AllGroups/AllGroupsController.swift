//
//  AllGroupsController.swift
//  MyVK
//
//  Created by Владимир Моторкин on 01.02.2022.
//

import UIKit
import RealmSwift

class AllGroupsController: UITableViewController {
    private var userId = ""
    private var accessToken = ""
    
    var groups = [Group]()
    private var resultSearchController = UISearchController()
    
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
            controller.searchBar.delegate = self
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allGroupsCell", for: indexPath) as! AllGroupsCell
        
        let group = groups[indexPath.row]
        cell.config(with: group)
        
        return cell
    }
}

extension AllGroupsController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // MARK: - Проблема с фильтрацией вывода только групп пользователя.
        let vkService = VKService(userId, accessToken)
        vkService.loadGroupsDataBySearch(search: searchBar.text!, completion: { searchGroups in
            //Не работает contains...
            //self.groups.removeAll(where: self.userGroups.contains(_:))
            
            let groupsWithoutUserGroups = searchGroups.filter( { (searchGroup) -> Bool in
                for userGroup in self.userGroups  {
                    if searchGroup == userGroup  {
                        return false
                    }
                }
                return true
            })
            self.groups = groupsWithoutUserGroups
            self.tableView.reloadData()
        })
        
    }
}
