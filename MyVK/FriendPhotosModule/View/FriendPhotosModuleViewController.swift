//
//  FriendPhotosModuleViewController.swift
//  MyVK
//
//  Created by Motorkin Vladimir on 02/03/2022.
//  Copyright © 2022 MVM. All rights reserved.
//

import UIKit

class FriendPhotosModuleViewController: UICollectionViewController {

    var output: FriendPhotosModuleViewOutput?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier:
                                    PhotosCollectionViewCell.reuseId)
        
        // Задаём высоту и ширину ячеек CollectionView.
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 128, height: 128)
        output?.viewIsReady()
    }
}

// MARK: - FriendPhotosModuleViewInput
extension FriendPhotosModuleViewController: FriendPhotosModuleViewInput {
    static func create() -> FriendPhotosModuleViewController {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let view = FriendPhotosModuleViewController(collectionViewLayout: layout)
        return view
    }
    
    func present(from vc: UIViewController) {
        vc.navigationController?.pushViewController(self, animated: true)
    }
    
    func updateData() {
        collectionView.reloadData()
    }
    
}

// MARK: - CollectionViewDataCource
extension FriendPhotosModuleViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseId, for: indexPath) as! PhotosCollectionViewCell
        
        if let photo = output?.getItem(row: indexPath.row) {
            cell.config(with: photo)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output?.itemsCount ?? 0
    }
    
}


