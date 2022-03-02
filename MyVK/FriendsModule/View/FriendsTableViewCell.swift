//
//  FriendsTableViewCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 25.02.2022.
//

import UIKit

class FriendsTableViewCell: ImageLabelTableViewCell {
    
    func config(with user: User?) {
        let text = (user?.firstName ?? "Фамилия") + " " + (user?.lastName ?? "Имя")
        name.text = text
        image.loadImage(from: user?.photo?.url)
    }
}
