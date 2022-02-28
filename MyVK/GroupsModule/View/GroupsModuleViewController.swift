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
    var plusButton: UIButton!
    @IBOutlet private var navigationView: UIView!
    @IBOutlet private var navigationViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.reuseId)
        plusButton = createPlusButton()
        self.view.addSubview(plusButton)
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
}

extension GroupsModuleViewController {
    func createPlusButton() -> UIButton {
        var configuration = UIButton.Configuration.bordered()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .blue
        let button = UIButton(configuration: configuration)
        button.contentHorizontalAlignment = .center
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }
    
    func setupConstraints() {
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            plusButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -53),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    override func viewWillLayoutSubviews() {
        
        //roundButton.backgroundColor = UIColor.lightGray
        plusButton.clipsToBounds = true
        plusButton.setImage(UIImage(named:"plus"), for: .normal)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -3),
            plusButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -53),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50)])
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
