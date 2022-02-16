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
        tableView.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
        
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
        return news.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseId, for: indexPath) as! NewsfeedCodeCell
        
        let news = news[indexPath.row]
        
        print(indexPath.row)
        print(news.postText)
        print(news.postImageURL)

        cell.config(with: news)
        
        return cell
    }
    


}

extension NewsfeedController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            print("kek")
        }
    }
}
