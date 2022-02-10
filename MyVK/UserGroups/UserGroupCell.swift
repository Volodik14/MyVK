//
//  UserGroupCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 01.02.2022.
//

import UIKit

class UserGroupCell: UITableViewCell {

    @IBOutlet weak var groupImage: CachedImageView!
    @IBOutlet weak var groupName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.groupImage.image = nil
    }
    

    func config (with group: Group) {
        let groupName = group.name
        if let groupPhoto = group.photo {
            self.groupImage.imageUrl = groupPhoto.url
            self.groupImage.loadImage(from: self.groupImage.imageUrl)
        } else {
            groupImage.image = UIImage(systemName: "circle")
        }
        self.groupName.text = groupName
    }

}
