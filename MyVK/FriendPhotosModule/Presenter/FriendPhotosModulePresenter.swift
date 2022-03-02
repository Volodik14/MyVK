//
//  FriendPhotosModulePresenter.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendPhotosModulePresenter {
    weak var view: FriendPhotosModuleViewInput!
    weak var output: FriendPhotosModuleModuleOutput?
    var interactor: FriendPhotosModuleInteractorInput!
    var router: FriendPhotosModuleRouterInput!

    private var userPhotos = [Photo]()
}

// MARK: - Present
extension FriendPhotosModulePresenter {
    func present(from vc: UIViewController) {
        view.present(from: vc)
    }
}

// MARK: - FriendPhotosModuleViewOutput
extension FriendPhotosModulePresenter: FriendPhotosModuleViewOutput {
    var itemsCount: Int {
        userPhotos.count
    }
    
    func getItem(row: Int) -> Photo {
        userPhotos[row]
    }
    
    func viewIsReady() {
        interactor.getPhotos()
    }
}

// MARK: - FriendPhotosModuleInteractorOutput
extension FriendPhotosModulePresenter: FriendPhotosModuleInteractorOutput {
    func getPhotosSuccess(model: [Photo]) {
        self.userPhotos = model
        print(userPhotos.count)
        view.updateData()
    }
    
    func getPhotosFail(error: String) {
        print(error)
    }
    

}
