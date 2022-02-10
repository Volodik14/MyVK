//
//  CachedImageView.swift
//  QFree
//
//  Created by Саид Дагалаев on 19.12.2020.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CachedImageView: UIImageView {
    var imageUrl: String?
    var placeholderImage = UIImage(named: "placeholder")
    
    func loadImage(from urlStr: String?) {
        guard urlStr != nil else { return }
        
        image = placeholderImage
        imageUrl = urlStr
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlStr!)) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: urlStr!) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                print(err)
            } else {
                DispatchQueue.main.async {
                    let imageFromData = UIImage(data: data!)
                    if self.imageUrl == urlStr {
                        self.image = imageFromData
                    }
                    imageCache.setObject(imageFromData!, forKey: NSString(string: urlStr!))
                }
            }
        }.resume()
    }
}
