//
//  AllGroupsModuleViewController.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class AllGroupsModuleViewController: UIViewController {

    var output: AllGroupsModuleViewOutput?
    @IBOutlet private var navigationView: UIView!
    @IBOutlet private var navigationViewHeightConstraint: NSLayoutConstraint!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
}

// MARK: - AllGroupsModuleViewInput
extension AllGroupsModuleViewController: AllGroupsModuleViewInput {
    
    static func create() -> GroupsModuleViewController {
        let view = GroupsModuleViewController()
        return view
    }
    
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

// MARK: - ViewControllerable
extension AllGroupsModuleViewController: ViewControllerable {
    static func storyBoardName() -> String {
        return "AllGroupsModule"
    }
}
