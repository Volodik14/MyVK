//
//  TabBarModulePresenter.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 28/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class TabBarModulePresenter {
    weak var view: TabBarModuleViewInput!
    weak var output: TabBarModuleModuleOutput?
    var interactor: TabBarModuleInteractorInput!
    var router: TabBarModuleRouterInput!

    private var closeView: (() -> ())?
    private var closeImage: UIImage?
}

// MARK: - Present
extension TabBarModulePresenter {

}

// MARK: - TabBarModuleViewOutput
extension TabBarModulePresenter: TabBarModuleViewOutput {
    func viewIsReady() {

    }
    
}

// MARK: - TabBarModuleInteractorOutput
extension TabBarModulePresenter: TabBarModuleInteractorOutput {

}
