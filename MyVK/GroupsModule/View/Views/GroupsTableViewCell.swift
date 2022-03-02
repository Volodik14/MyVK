//
//  GroupsTableViewCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 02.03.2022.
//

import UIKit

class GroupsTableViewCell: ImageLabelTableViewCell {
    func config (with group: Group?) {
        name.text = group?.name ?? "Группа"
        image.loadImage(from: group?.photo?.url)
    }
}
