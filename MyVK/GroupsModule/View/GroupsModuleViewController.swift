//
//  GroupsModuleViewController.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class GroupsModuleViewController: UITableViewController {

    var output: GroupsModuleViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier:
                            GroupsTableViewCell.reuseId)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addTapped))
        output?.viewIsReady()
        
    }
    
    
    
}

extension GroupsModuleViewController: GroupsModuleViewInput {
    func updateData() {
        tableView.reloadData()
    }
    
    static func create() -> GroupsModuleViewController {
        let view = GroupsModuleViewController()
        return view
    }
    
    @objc func addTapped() {
        output?.plusButtonClicked(view: self)
    }
}


extension GroupsModuleViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.itemsCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reuseId) as! GroupsTableViewCell
        let group = output?.getItem(row: indexPath.row)
        cell.config(with: group)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}
