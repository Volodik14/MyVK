//
//  NewsfeedCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 10.02.2022.
//

import UIKit

class NewsfeedCell: UITableViewCell {

    @IBOutlet weak var heightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var postImage: CachedImageView!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var repostsLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var avatarImage: CachedImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config (with news: News) {
        if news.postImageURL == "" {
            postImage.removeFromSuperview()
        } else {
            self.postImage.loadImage(from: news.postImageURL)
        }
        
        self.avatarImage.loadImage(from: news.authorImageURL)
        self.viewsLabel.text = news.viewsCount
        self.postTextView.text = news.postText
        self.repostsLabel.text = news.repostsCount
        self.commentsLabel.text = news.commentsCount
        self.likesLabel.text = news.likesCount
        self.authorName.text = news.authorName
        self.heightLayoutConstraint.constant = self.postTextView.contentSize.height
    }

}
