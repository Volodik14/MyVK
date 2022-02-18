//
//  NewsfeedCodeCell.swift
//  MyVK
//
//  Created by Владимир Моторкин on 15.02.2022.
//

import UIKit

class NewsfeedCodeCell: UITableViewCell {
    
    
    private class imageCountStackView: UIStackView {
        private let image = UIImageView()
        private let likesLabel = UILabel()
        
        init(imageName: String) {
            super.init(frame: .zero)
            self.axis  = .horizontal
            self.distribution = .fill
            self.alignment = .center
            self.spacing = 5
            self.translatesAutoresizingMaskIntoConstraints = false
            self.image.translatesAutoresizingMaskIntoConstraints = false
            self.image.image = UIImage(named: imageName)
            self.image.widthAnchor.constraint(equalToConstant: 15).isActive = true
            self.image.heightAnchor.constraint(equalToConstant: 15).isActive = true
            self.addArrangedSubview(image)
            self.addArrangedSubview(likesLabel)
        }
        
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func config(text: String) {
            likesLabel.text = text
        }
        
    }
    
    static let reuseId = String(describing: self)
    
    private var height = CGFloat(62)
    
    private let viewsStackView = imageCountStackView(imageName: "view")
    private let likesStackView = imageCountStackView(imageName: "love")
    private let repostsStackView = imageCountStackView(imageName: "repost")
    private let commentsStackView = imageCountStackView(imageName: "comment")
    private let countersStackView = UIStackView()
    
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
    
    private lazy var postTextViewHeight: NSLayoutConstraint = {
        return postTextView.heightAnchor.constraint(equalToConstant: 50)
    }()
    
    private func setViews() {
        setAuthorImage()
        setAuthorName()
        //setViewsStackView()
        //setLikesStackView()
        //setRepostsStackView()
        //setCommentsStackView()
        setCountersStackView()
        //setViewsImage()
        //setViewsLabel()
        //setLikesImage()
        //setLikesLabel()
        //setRepostsImage()
        //setRepostsLabel()
        //setCommentsImage()
        //setCommentsLabel()
        setPostTextView()
        //setPostImageView()
    }
    
    private func setCountersStackView() {
        contentView.addSubview(countersStackView)
        countersStackView.axis  = .horizontal
        countersStackView.distribution = .fill
        countersStackView.alignment = .center
        countersStackView.spacing = 5
        countersStackView.translatesAutoresizingMaskIntoConstraints = false
        countersStackView.addArrangedSubview(viewsStackView)
        countersStackView.addArrangedSubview(likesStackView)
        countersStackView.addArrangedSubview(repostsStackView)
        countersStackView.addArrangedSubview(commentsStackView)
        countersStackView.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 5).isActive = true
        countersStackView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 7).isActive = true
    }
    
    private func setViewsStackView() {
        contentView.addSubview(viewsStackView)
        viewsStackView.translatesAutoresizingMaskIntoConstraints = false
        viewsStackView.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 5).isActive = true
        viewsStackView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 7).isActive = true
    }
    
    private func setLikesStackView() {
        contentView.addSubview(likesStackView)
        likesStackView.translatesAutoresizingMaskIntoConstraints = false
        likesStackView.leftAnchor.constraint(equalTo: viewsStackView.rightAnchor, constant: 5).isActive = true
        likesStackView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 7).isActive = true
    }
    
    private func setRepostsStackView() {
        contentView.addSubview(repostsStackView)
        repostsStackView.translatesAutoresizingMaskIntoConstraints = false
        repostsStackView.leftAnchor.constraint(equalTo: likesStackView.rightAnchor, constant: 5).isActive = true
        repostsStackView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 7).isActive = true
    }
    
    private func setCommentsStackView() {
        contentView.addSubview(commentsStackView)
        commentsStackView.translatesAutoresizingMaskIntoConstraints = false
        commentsStackView.leftAnchor.constraint(equalTo: repostsStackView.rightAnchor, constant: 5).isActive = true
        commentsStackView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 7).isActive = true
    }
    
    
    
    private func setAuthorImage() {
        contentView.addSubview(avatarImage)
        avatarImage.contentMode = .scaleAspectFit
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
        authorName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
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
        repostsImageView.image = UIImage(named: "repost")
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
        postTextView.isScrollEnabled = true
        postTextView.translatesAutoresizingMaskIntoConstraints = false
        postTextView.topAnchor.constraint(equalTo: avatarImage.bottomAnchor).isActive = true
        postTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        postTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        postTextViewHeight.isActive = true
    }
    
    private func setPostImageView(news: News) {
        contentView.addSubview(postImage)
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.topAnchor.constraint(equalTo: postTextView.bottomAnchor).isActive = true
        postImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        postImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        postImage.contentMode = .scaleToFill
        let aspectRatio = CGFloat(news.postImageHeight) / CGFloat(news.postImageWidth)
        postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor, multiplier: aspectRatio).isActive = true
        postImage.loadImage(from: news.postImageURL)
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
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        postImage.image = nil
        postImage.removeFromSuperview()
        postTextView.removeFromSuperview()
        //postTextView.text = nil
        //viewsLabel.text = nil
        //repostsLabel.text = nil
        //commentsLabel.text = nil
        //likesLabel.text = nil
        //authorName.text = nil
        //viewsImageView.image = nil
        //repostsImageView.image = nil
        //commentsImageView.image = nil
        //likesImageView.image = nil
        avatarImage.image = nil
    }
    
    func config (with news: News) {
        setPostTextView()
        if news.postText == "" {
            postTextViewHeight.constant = 0
        } else {
            self.postTextView.text = news.postText
            postTextViewHeight.constant = 50
        }
        
        if news.postImageURL == "" {
            //postImage.isHidden = true
            postTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        } else {
            setPostImageView(news: news)
            //self.postImage.heightAnchor.constraint(equalToConstant: CGFloat(news.postImageHeight)).isActive = true
        }
        
        height += CGFloat(news.postImageHeight) + postTextViewHeight.constant
        //let constraint = contentView.heightAnchor.constraint(equalToConstant: height)
        //constraint.priority = UILayoutPriority(rawValue: 999)
        //constraint.isActive = true
        
        
        self.avatarImage.loadImage(from: news.authorImageURL)
        
        
        self.authorName.text = news.authorName
        // Почему-то не работает.
        //let heightText = min(postTextView.intrinsicContentSize.height, 80)
        //self.postTextView.heightAnchor.constraint(equalToConstant: heightText).isActive = true
        viewsStackView.config(text: news.viewsCount)
        likesStackView.config(text: news.likesCount)
        repostsStackView.config(text: news.repostsCount)
        commentsStackView.config(text: news.commentsCount)
        //setLabel(label: self.viewsLabel, text: news.viewsCount)
        //setLabel(label: self.likesLabel, text: news.likesCount)
        //setLabel(label: self.repostsLabel, text: news.repostsCount)
        //setLabel(label: self.commentsLabel, text: news.commentsCount)
        
    }

}
