//
//  FriendsModuleViewController.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendsModuleViewController: UITableViewController {
    
    private var friends = [User]()

    var output: FriendsModuleViewOutput?
    @IBOutlet private var navigationView: UIView!
    @IBOutlet private var navigationViewHeightConstraint: NSLayoutConstraint!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.reuseId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output?.viewIsReady(tableView: tableView)
    }
    
    
}

extension FriendsModuleViewController: FriendsModuleViewInput {
    func updateData(friends: [User]) {
        self.friends = friends
        tableView.reloadData()
    }
    
    static func create() -> FriendsModuleViewController {
        let view = FriendsModuleViewController()
        return view
    }
}

// MARK: - FriendsModuleViewInput
/*
extension FriendsModuleViewController: FriendsModuleViewInput {
    func setupNavigationBar(title: String, leftButtonImage: UIImage?) {
        if let navigationView = NavigationBarView.instanceFromNib(with: NSAttributedString(string: title), parentView: navigationView, parentViewHeightConstraint: navigationViewHeightConstraint) {
            navigationView.setLeftBarButton(with: leftButtonImage, titleLabel: nil, color: .black, tap: { [weak self] in
                self?.output?.tapNavigationLeftBarButton()
            })

            self.view.backgroundColor = ColorStyle.navigationBar.color()
            navigationView.backgroundColor = ColorStyle.navigationBar.color()
            navigationController?.navigationBar.isHidden = true
        }
    }
}
*/
// MARK: - ViewControllerable
/*
extension FriendsModuleViewController: ViewControllerable {
    static func storyBoardName() -> String {
        return "FriendsModule"
    }
}
*/

extension FriendsModuleViewController {
    // Перезод на контроллер показа фото.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showFriendPhotos") {
            let friendsPhotosController = (segue.destination as! FriendPhotosController)
            if let row = tableView.indexPathForSelectedRow?.row {
                friendsPhotosController.userId = friends[row].id
            }
            
            
        }
    }
}

extension FriendsModuleViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseId) as! FriendsTableViewCell
        cell.config(with: friends[indexPath.row])
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FriendPhotosController") as? FriendPhotosController {
            viewController.userId = friends[indexPath.row].id
            self.navigationController?.pushViewController(viewController, animated: true)
           }
        
        
    }
    
    
}
