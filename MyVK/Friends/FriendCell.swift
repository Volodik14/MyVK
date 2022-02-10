//
//  FriendCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 01.02.2022.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var friendPhoto: CachedImageView!
    @IBOutlet weak var friendName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.friendPhoto.image = nil
    }
    

    func config (with friend: User) {
        let friendName = friend.firstName + " " + friend.lastName
        if let friendPhoto = friend.photo {
            self.friendPhoto.imageUrl = friendPhoto.url
            self.friendPhoto.loadImage(from: self.friendPhoto.imageUrl)
        } else {
            friendPhoto.image = UIImage(systemName: "circle")
        }
        self.friendName.text = friendName
    }
}
