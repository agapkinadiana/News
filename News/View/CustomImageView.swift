//
//  CustomImageView.swift
//  News
//
//  Created by Diana Agapkina on 10/29/20.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var urlString: String?
    
    func loadImageUsingURLString(_ urlString: String) {
        self.urlString = urlString
        image = UIImage() 
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            image = cachedImage
            return
        }
        
        guard let imageURL = URL(string: urlString) else { return }
        let request: URLRequest = URLRequest(url: imageURL)
        
        NetworkService().getDataFromRequest(request) { [weak self] (data, error) in

            guard let data = data, let imageToCache = UIImage(data: data) else {
                print("Please check your Web connection and Feed URL!")
                return
            }
            imageCache.setObject(imageToCache, forKey: NSString(string: urlString))
            
            if self?.urlString == urlString {
                DispatchQueue.main.async {
                    self?.image = imageToCache
                }
            }
        }
    }
}
