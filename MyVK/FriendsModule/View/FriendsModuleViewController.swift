//
//  FriendsModuleViewController.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendsModuleViewController: UIViewController {
    
    private var tableView: UITableView!
    private var friends = [User]()

    var output: FriendsModuleViewOutput?
    @IBOutlet private var navigationView: UIView!
    @IBOutlet private var navigationViewHeightConstraint: NSLayoutConstraint!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
    
    
}

extension FriendsModuleViewController: FriendsModuleViewInput {
    func updateData(friends: [User]) {
        self.friends = friends
        tableView.reloadData()
    }
    
    static func create() -> FriendsModuleViewInput {
        let view = FriendsModuleViewController()
        view.tableView = UITableView()
        view.tableView.dataSource = view
        view.tableView.delegate = view
        view.view.addSubview(view.tableView)
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

extension FriendsModuleViewController: UITableViewDelegate {
    
}

extension FriendsModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Kek") as! UITableViewCell
        return cell
    }
    
    
}
