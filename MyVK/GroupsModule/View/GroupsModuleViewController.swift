//
//  GroupsModuleViewController.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class GroupsModuleViewController: UITableViewController {
    
    private var groups = [Group]()

    var output: GroupsModuleViewOutput?
    @IBOutlet private var navigationView: UIView!
    @IBOutlet private var navigationViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier:
                            FriendsTableViewCell.reuseId)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addTapped))
        //plusButton = createPlusButton()
        //setupConstraints()
        output?.viewIsReady()
        
    }
    
    
    
}

extension GroupsModuleViewController: GroupsModuleViewInput {
    func updateData(groups: [Group]) {
        self.groups = groups
        tableView.reloadData()
    }
    
    func addGroup(group: Group) {
        self.groups.append(group)
        tableView.reloadData()
    }
    
    static func create() -> GroupsModuleViewController {
        let view = GroupsModuleViewController()
        return view
    }
    
    @objc func addTapped() {
        output?.plusButtonClicked(view: self, groups: groups)
    }
}


extension GroupsModuleViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseId) as! FriendsTableViewCell
        cell.config(with: groups[indexPath.row])
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    
    
}
