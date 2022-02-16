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
    private let avatarImage = CachedImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //selectionStyle = .none
        setViews()
    }
    
    private func setViews() {
        setAuthorImage()
        setAuthorName()
        setViewsLabel()
        setRepostsLabel()
        setCommentsLabel()
        setLikesLabel()
        setPostTextView()
        setPostImageView()
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
    
    private func setViewsLabel() {
        contentView.addSubview(viewsLabel)
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 5).isActive = true
        viewsLabel.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 6).isActive = true
    }
    
    private func setRepostsLabel() {
        contentView.addSubview(repostsLabel)
        repostsLabel.translatesAutoresizingMaskIntoConstraints = false
        repostsLabel.leftAnchor.constraint(equalTo: viewsLabel.rightAnchor, constant: 5).isActive = true
        repostsLabel.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 6).isActive = true
    }
    
    
    private func setCommentsLabel() {
        contentView.addSubview(commentsLabel)
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.leftAnchor.constraint(equalTo: repostsLabel.rightAnchor, constant: 5).isActive = true
        commentsLabel.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 6).isActive = true
    }
    
    private func setLikesLabel() {
        contentView.addSubview(repostsLabel)
        repostsLabel.translatesAutoresizingMaskIntoConstraints = false
        repostsLabel.leftAnchor.constraint(equalTo: commentsLabel.rightAnchor, constant: 5).isActive = true
        repostsLabel.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 6).isActive = true
    }
    
    private func setPostTextView() {
        contentView.addSubview(postTextView)
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
        postImage.contentMode = .bottomLeft
        //postImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config (with news: News) {
        //if news.postImageURL == "" {
        //    postImage.removeFromSuperview()
        //} else {
            self.postImage.loadImage(from: news.postImageURL)
        //}
        self.postImage.heightAnchor.constraint(equalToConstant: CGFloat(news.postImageHeight)).isActive = true
        
        self.avatarImage.loadImage(from: news.authorImageURL)
        self.viewsLabel.text = news.viewsCount
        self.postTextView.text = news.postText
        self.repostsLabel.text = news.repostsCount
        self.commentsLabel.text = news.commentsCount
        self.likesLabel.text = news.likesCount
        self.authorName.text = news.authorName
    }

}
