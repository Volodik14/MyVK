//
//  FriendPhotosController.swift
//  MyVK
//
//  Created by Владимир Моторкин on 01.02.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendPhotosController: UICollectionViewController {
    
    private var userPhotos = [Photo]()
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Получаем токен и id пользователя.
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            let vkService = VKService(userId, accessToken)
            vkService.loadUserProfilePhotos(userId: userId, completion: {photos in
                //print("photos \(photos)")
                self.userPhotos = photos
                self.collectionView.reloadData()
            })
        } else {
            print("Cannot get data, cannot get access token!")
        }
    }
    
    
    // MARK: - UICollectionViewDataSource

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotosCell", for: indexPath) as! FriendPhotosCell
        
        let photo = userPhotos[indexPath.row]
        cell.config(with: photo)
        
        return cell
    }
    
}
