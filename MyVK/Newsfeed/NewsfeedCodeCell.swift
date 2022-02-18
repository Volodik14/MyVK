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
    private let authorName = UILabel()
    private let avatarImage = CachedImageView()
    
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
        setCountersStackView()
        setPostTextView()
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
    
    private func setAuthorImage() {
        contentView.addSubview(avatarImage)
        avatarImage.contentMode = .scaleAspectFit
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
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
    


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        postImage.image = nil
        postImage.removeFromSuperview()
        postTextView.removeFromSuperview()
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

        self.avatarImage.loadImage(from: news.authorImageURL)
        
        self.authorName.text = news.authorName
        
        viewsStackView.config(text: news.viewsCount)
        likesStackView.config(text: news.likesCount)
        repostsStackView.config(text: news.repostsCount)
        commentsStackView.config(text: news.commentsCount)

    }

}
