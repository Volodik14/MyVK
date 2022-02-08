//
//  FriendCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 01.02.2022.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var friendPhoto: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
