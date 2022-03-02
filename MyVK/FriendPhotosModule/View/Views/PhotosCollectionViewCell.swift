//
//  PhotosCollectionViewCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 02.03.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    let friendPhoto = CachedImageView()
    
    static let reuseId = String(describing: self)
    
    override func prepareForReuse() {
        self.friendPhoto.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        friendPhoto.clipsToBounds = true
        friendPhoto.contentMode = .scaleAspectFit
        friendPhoto.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(friendPhoto)
        NSLayoutConstraint.activate([
            friendPhoto.topAnchor.constraint(equalTo: contentView.topAnchor),
            friendPhoto.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            friendPhoto.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            friendPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config (with photo: Photo?) {
        let photoUrl = photo?.url ?? ""
        self.friendPhoto.imageUrl = photoUrl
        self.friendPhoto.loadImage(from: self.friendPhoto.imageUrl)
    }
}
