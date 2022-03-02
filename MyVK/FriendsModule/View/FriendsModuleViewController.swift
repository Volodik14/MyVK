//
//  FriendsModuleViewController.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendsModuleViewController: UITableViewController {

    var output: FriendsModuleViewOutput?

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
    static func create() -> FriendsModuleViewController {
        let view = FriendsModuleViewController()
        return view
    }
    
    func updateData() {
        tableView.reloadData()
    }
}
// MARK: - TableView
extension FriendsModuleViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.itemsCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseId) as! FriendsTableViewCell
        let friend = output?.getItem(row: indexPath.row)
        cell.config(with: friend)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.showFriendsPhoto(sender: self, row: indexPath.row)
    }
}
