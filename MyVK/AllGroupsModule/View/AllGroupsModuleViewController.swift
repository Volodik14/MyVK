//
//  AllGroupsModuleViewController.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class AllGroupsModuleViewController: UITableViewController {

    var output: AllGroupsModuleViewOutput?
    
    private var resultSearchController = UISearchController()
    

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resultSearchController = createSearchController()
        tableView.register(AllGroupsTableViewCell.self, forCellReuseIdentifier:
                            AllGroupsTableViewCell.reuseId)
        output?.viewIsReady()
    }
    
    func createSearchController() -> UISearchController {
        return ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.delegate = self
            controller.searchBar.sizeToFit()
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
    }
}

// MARK: - AllGroupsModuleViewInput
extension AllGroupsModuleViewController: AllGroupsModuleViewInput {
    func present(from vc: UIViewController) {
        vc.navigationController?.pushViewController(self, animated: true)
    }
    
    static func create() -> AllGroupsModuleViewController {
        let view = AllGroupsModuleViewController()
        return view
    }
    
    func updateData() {
        tableView.reloadData()
    }
}

// MARK: - TableView
extension AllGroupsModuleViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.itemsCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllGroupsTableViewCell.reuseId) as! AllGroupsTableViewCell
        let group = output?.getItem(row: indexPath.row)
        cell.config(with: group)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultSearchController.dismiss(animated: true)
        output?.addGroup(sender: self, row: indexPath.row)
    }
}

// MARK: - Search bar delegate.
extension AllGroupsModuleViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        output?.getGroups(search: searchBar.text ?? "")
    }
}
