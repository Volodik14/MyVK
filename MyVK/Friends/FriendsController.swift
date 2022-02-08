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

    var friends = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        print("friends \(friends.count)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        tableView.reloadData()
    }
    
    func loadData() {
        do {
            let realm = try Realm()
            
            let friends = realm.objects(User.self)
            
            self.friends = Array(friends)
        } catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showFriendPhotos") {
            let friendsPhotosController = (segue.destination as! FriendPhotosController)
            if let row = tableView.indexPathForSelectedRow?.row {
                friendsPhotosController.userId = friends[row].id
            }
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        let friend = friends[indexPath.row]
        
        let friendName = friend.firstName + " " + friend.lastName
        cell.friendPhoto.image = nil
        if let friendPhoto = friend.photo {
            let url = URL(string: friendPhoto.url)!
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        var image = UIImage(data: data)
                        //image = image?.scalePreservingAspectRatio(targetSize: CGSize(width: 26, height: 26))
                        //cell.friendPhoto.clipsToBounds = true
                        cell.friendPhoto.image = image
                        //self.tableView.reloadRows(at: [indexPath], with: .none)
                        //TODO: Починить отображение
                    }
                }
            }
        } else {
            cell.friendPhoto.image = UIImage(systemName: "circle")
        }
        
        
        cell.friendName.text = friendName
        
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
