//
//  NewsCollectionViewCell.swift
//  News
//
//  Created by Diana Agapkina on 10/29/20.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    @IBOutlet weak var image: CustomImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var newsDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: NewsItem!) {
        setupUI()
        
        title.text = item.title
        newsDescription.text = item.details
        if let imageUrl = item.imageURL {
            image.loadImageUsingURLString(imageUrl)           
        }
    }
    
    func setupUI() {
        colorView.layer.cornerRadius = 10.0
        colorView.layer.masksToBounds = true
        image.layer.cornerRadius = 10.0
        image.layer.masksToBounds = true
    }
}
