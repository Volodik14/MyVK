//
//  AllGroupsController.swift
//  MyVK
//
//  Created by Владимир Моторкин on 01.02.2022.
//

import UIKit
import RealmSwift

class AllGroupsController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let vkService = VKService(myData.userId, myData.accessToken)
        vkService.loadGroupsDataBySearch(search: searchController.searchBar.text!, completion: { searchGroups in
            self.groups = searchGroups
        })
        self.tableView.reloadData()
    }
        
    var groups = [Group]()
    var resultSearchController = UISearchController()

    var userGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadData()
        
        
        
        resultSearchController = ({
                let controller = UISearchController(searchResultsController: nil)
                controller.searchResultsUpdater = self
                controller.dimsBackgroundDuringPresentation = false
                controller.searchBar.sizeToFit()

                tableView.tableHeaderView = controller.searchBar

                return controller
            })()

            // Reload the table
            tableView.reloadData()
        
        //groups.removeAll(where: userGroups.contains(_:))
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allGroupsCell", for: indexPath) as! AllGroupsCell
        
        let group = groups[indexPath.row]

        let groupName = group.name
        let membersCount = group.countMembers
        
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
