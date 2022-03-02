//
//  AllGroupsTableViewCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 02.03.2022.
//

import UIKit

class AllGroupsTableViewCell: ImageLabelTableViewCell {
    
    internal let groupSubsCount = UILabel()

    override func setViews() {
        setImage()
        setName()
        setSubsCount()
    }
    
    func setSubsCount() {
        groupSubsCount.font = groupSubsCount.font.withSize(10)
        
        contentView.addSubview(groupSubsCount)
        
        groupSubsCount.translatesAutoresizingMaskIntoConstraints = false
        groupSubsCount.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 5).isActive = true
        groupSubsCount.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
    }
    
    func config (with group: Group?) {
        name.text = group?.name ?? "Группа"
        groupSubsCount.text = group?.countMembers ?? "0"
        image.loadImage(from: group?.photo?.url)
    }

}
