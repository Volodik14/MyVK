//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendsModuleModule {
    private let presenter = FriendsModulePresenter()
    private let view: FriendsModuleViewInput

    init(output: FriendsModuleModuleOutput) {
        let interactor = FriendsModuleInteractor()
        interactor.output = presenter

        view = FriendsModuleViewController.create()
        view.output = presenter

        presenter.output = output
        presenter.view = view
        presenter.router = FriendsModuleRouter()
        presenter.interactor = interactor
    }
}

// MARK: FriendsModuleModuleInput
extension FriendsModuleModule: FriendsModuleModuleInput {
    /*
    func present(from viewController: UIViewController) {
        <#code#>
    }
    
    func presentAsNavController(from vc: UIViewController) {
        <#code#>
    }
    */

}
