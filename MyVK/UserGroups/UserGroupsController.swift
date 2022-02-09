//
//  UserGroupsController.swift
//  MyVK
//
//  Created by Владимир Моторкин on 01.02.2022.
//

import UIKit
import RealmSwift

class UserGroupsController: UITableViewController {
    var userGroups = [Group]()
    var accessToken = ""
    var userId = ""
    
    @IBAction func addGroup(unwindSegue: UIStoryboardSegue) {
        // Проверяем идентификатор перехода, чтобы убедится, что это нужный переход.
        if unwindSegue.identifier == "addGroup" {
            // Получаем ссылку на контроллер, с которого осуществлен переход.
            let allGroupsController = unwindSegue.source as! AllGroupsController
            
            // Получаем индекс выделенной ячейки
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                // Получаем группу по индексу
                let group = allGroupsController.groups[indexPath.row]
                // Добавляем группу в список выбранных городов
                userGroups.append(group)
                // Вступаем в группу.
                //let vkService = VKService(userId, accessToken)
                //vkService.joinGroup(groupId: group.id)
                // обновляем таблицу
                tableView.reloadData()
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Если была нажата кнопка удалить
        if editingStyle == .delete {
            // Выходим из группы.
            //let vkService = VKService(userId, accessToken)
            //vkService.leaveGroup(groupId: userGroups[indexPath.row].id)
            // Удаляем группу из своих.
            userGroups.remove(at: indexPath.row)
            // Удаляем строку с ней.
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Получаем токен и id пользователя.
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
        
        loadData()
        
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
        return userGroups.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showGroups") {
            let allGroupsViewController = (segue.destination as! AllGroupsController)
            allGroupsViewController.userGroups = userGroups
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "userGroupsCell", for: indexPath) as! UserGroupCell
        
        let group = userGroups[indexPath.row]

        let groupName = group.name
        
        let url = URL(string: group.photo!.url)!
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    cell.groupImage.image = UIImage(data: data)
                }
            }
        }

        cell.groupName.text = groupName
         
        return cell
     }
     
    
}
