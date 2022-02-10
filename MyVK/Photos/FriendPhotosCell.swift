//
//  FriendPhotosCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 01.02.2022.
//

import UIKit

class FriendPhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var friendPhoto: CachedImageView!
    
    override func prepareForReuse() {
        self.friendPhoto.image = nil
    }
    

    func config (with photo: Photo) {
        let photoUrl = photo.url
        self.friendPhoto.imageUrl = photoUrl
        self.friendPhoto.loadImage(from: self.friendPhoto.imageUrl)
    }
}
