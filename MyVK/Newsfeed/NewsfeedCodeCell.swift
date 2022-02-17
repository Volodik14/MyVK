//
//  NewsfeedCodeCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 15.02.2022.
//

import UIKit

class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseId = String(describing: self)
    
    private let postImage = CachedImageView()
    private let postTextView = UITextView()
    private let viewsLabel = UILabel()
    private let repostsLabel = UILabel()
    private let commentsLabel = UILabel()
    private let likesLabel = UILabel()
    private let authorName = UILabel()
    private let viewsImageView = UIImageView()
    private let repostsImageView = UIImageView()
    private let commentsImageView = UIImageView()
    private let likesImageView = UIImageView()
    
    private let avatarImage = CachedImageView()
    
    private let insets: CGFloat = 5.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setViews()
    }
    
    private func setViews() {
        setAuthorImage()
        setAuthorName()
        setViewsImage()
        setViewsLabel()
        setLikesImage()
        setLikesLabel()
        setRepostsImage()
        setRepostsLabel()
        setCommentsImage()
        setCommentsLabel()
        setPostTextView()
        //setPostImageView()
    }
    
    private func setAuthorImage() {
        contentView.addSubview(avatarImage)
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.backgroundColor = .red
        avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        avatarImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setAuthorName() {
        contentView.addSubview(authorName)
        authorName.translatesAutoresizingMaskIntoConstraints = false
        authorName.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 5).isActive = true
        authorName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
    }
    
    private func setViewsImage() {
        contentView.addSubview(viewsImageView)
        viewsImageView.translatesAutoresizingMaskIntoConstraints = false
        viewsImageView.image = UIImage(named: "view")
        viewsImageView.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 5).isActive = true
        viewsImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        viewsImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        viewsImageView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 7).isActive = true
    }
    
    private func setViewsLabel() {
        contentView.addSubview(viewsLabel)
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.leftAnchor.constraint(equalTo: viewsImageView.rightAnchor, constant: 5).isActive = true
        viewsLabel.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 6).isActive = true
    }
    
    
    private func setLikesLabel() {
        contentView.addSubview(likesLabel)
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.leftAnchor.constraint(equalTo: likesImageView.rightAnchor, constant: 5).isActive = true
        likesLabel.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 6).isActive = true
    }
    
    private func setLikesImage() {
        contentView.addSubview(likesImageView)
        likesImageView.translatesAutoresizingMaskIntoConstraints = false
        likesImageView.image = UIImage(named: "love")
        likesImageView.leftAnchor.constraint(equalTo: viewsLabel.rightAnchor, constant: 5).isActive = true
        likesImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        likesImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        likesImageView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 7).isActive = true
    }
    
    private func setRepostsLabel() {
        contentView.addSubview(repostsLabel)
        repostsLabel.translatesAutoresizingMaskIntoConstraints = false
        repostsLabel.leftAnchor.constraint(equalTo: repostsImageView.rightAnchor, constant: 5).isActive = true
        repostsLabel.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 6).isActive = true
    }
    
    private func setCommentsImage() {
        contentView.addSubview(commentsImageView)
        commentsImageView.translatesAutoresizingMaskIntoConstraints = false
        commentsImageView.image = UIImage(named: "comment")
        commentsImageView.leftAnchor.constraint(equalTo: repostsLabel.rightAnchor, constant: 5).isActive = true
        commentsImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        commentsImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        commentsImageView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 7).isActive = true
    }
    
    private func setRepostsImage() {
        contentView.addSubview(repostsImageView)
        repostsImageView.translatesAutoresizingMaskIntoConstraints = false
        repostsImageView.image = UIImage(named: "comment")
        repostsImageView.leftAnchor.constraint(equalTo: likesLabel.rightAnchor, constant: 5).isActive = true
        repostsImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        repostsImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        repostsImageView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 7).isActive = true
    }
    
    private func setCommentsLabel() {
        contentView.addSubview(commentsLabel)
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.leftAnchor.constraint(equalTo: commentsImageView.rightAnchor, constant: 5).isActive = true
        commentsLabel.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 6).isActive = true
    }
    
    private func setPostTextView() {
        contentView.addSubview(postTextView)
        postTextView.isEditable = false
        postTextView.translatesAutoresizingMaskIntoConstraints = false
        postTextView.topAnchor.constraint(equalTo: avatarImage.bottomAnchor).isActive = true
        postTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        postTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        postTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setPostImageView() {
        contentView.addSubview(postImage)
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.topAnchor.constraint(equalTo: postTextView.bottomAnchor).isActive = true
        postImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        postImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        postImage.contentMode = .scaleToFill
        //postImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    
    private func setLabel(label: UILabel, text: String) {
        label.text = text
        //label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config (with news: News) {
        if news.postImageURL == "" {
            //postImage.isHidden = true
            postTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        } else {
            setPostImageView()
            self.postImage.loadImage(from: news.postImageURL)
        }
        self.postImage.heightAnchor.constraint(equalToConstant: CGFloat(news.postImageHeight)).isActive = true
        
        self.avatarImage.loadImage(from: news.authorImageURL)
        
        if news.postText == "" {
            postTextView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        } else {
            self.postTextView.text = news.postText
        }
        self.postTextView.text = news.postText
        // Почему-то не работает.
        //let heightText = min(postTextView.intrinsicContentSize.height, 80)
        //self.postTextView.heightAnchor.constraint(equalToConstant: heightText).isActive = true
        setLabel(label: self.viewsLabel, text: news.viewsCount)
        setLabel(label: self.likesLabel, text: news.likesCount)
        setLabel(label: self.repostsLabel, text: news.repostsCount)
        setLabel(label: self.commentsLabel, text: news.commentsCount)
        self.likesLabel.text = news.likesCount
        self.authorName.text = news.authorName
    }

}
