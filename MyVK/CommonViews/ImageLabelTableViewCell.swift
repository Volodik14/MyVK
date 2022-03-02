//
//  ImageLabelTableViewCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 02.03.2022.
//

import UIKit

class ImageLabelTableViewCell: UITableViewCell {

    static let reuseId = String(describing: self)
    
    internal let image = CachedImageView()
    internal let name = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setViews()
    }
    
    internal func setViews() {
        setImage()
        setName()
    }
    
    internal func setImage() {
        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 50).isActive = true
        image.widthAnchor.constraint(equalToConstant: 50).isActive = true
        image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
    }
    
    internal func setName() {
        contentView.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 5).isActive = true
        name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config (text: String, imageURL: String) {
        name.text = text
        image.loadImage(from: imageURL)
    }


}
