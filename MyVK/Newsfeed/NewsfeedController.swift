//
//  NewsfeedController.swift
//  MyVK
//
//  Created by Владимир Моторкин on 10.02.2022.
//

import UIKit

class NewsfeedController: UITableViewController {
    
    private var userId = ""
    private var accessToken = ""
    private var news = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let vkService = VKService(userId, accessToken)
        vkService.loadNewsfeed(completion: {news in
            self.news = news
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsfeedCell", for: indexPath) as! NewsfeedCell
        
        let news = news[indexPath.row]
        
        print(indexPath.row)
        print(news.postText)
        print(news.postImageURL)

        cell.config(with: news)
        
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
