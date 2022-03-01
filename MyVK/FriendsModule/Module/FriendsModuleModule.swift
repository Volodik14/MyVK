//
//  Created by Motorkin Vladimir on 24/02/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendsModuleModule {
    private let presenter = FriendsModulePresenter()
    
    func configuredFiewController() -> UIViewController {
        let interactor = FriendsModuleInteractor()
        interactor.output = presenter

        let view = FriendsModuleViewController.create()
        view.output = presenter

        presenter.view = view
        presenter.router = FriendsModuleRouter()
        presenter.interactor = interactor
        return view
    }

}

// MARK: FriendsModuleModuleInput
extension FriendsModuleModule: FriendsModuleModuleInput {
    func present(from viewController: UIViewController) {
        if let viewController = UIStoryboard(name: "FriendsModule", bundle: nil).instantiateViewController(withIdentifier: "FriendsModuleViewController") as? FriendsModuleViewController {
            if let navigator = viewController.navigationController {
                   navigator.pushViewController(viewController, animated: true)
               }
           }
    }
}
