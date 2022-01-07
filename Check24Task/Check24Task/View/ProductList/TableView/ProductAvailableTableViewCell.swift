//
//  ProductAvailableTableViewCell.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import UIKit
import Kingfisher

final class ProductAvailableTableViewCell: UITableViewCell {

    @IBOutlet private weak var itemImage: UIImageView!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var secondLabel: UILabel!
    @IBOutlet private weak var ratingStackView: UIStackView!
    
    func configure(item: Product) {
        date.text = item.dateFormatted
        name.text = item.name
        secondLabel.text = item.description
        price.text = item.priceFormatted
        setStar(star: item.rating)
        guard let url = URL(string: item.imageURL) else {
            return
        }
        itemImage.kf.setImage(with: url)
    }
    
    private func setStar(star: Double) {
        ratingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for _ in 1...Int(star) {
            let starFull = UIImage(systemName: "star.fill")
            let imageView = UIImageView(image: starFull)
            imageView.tintColor = .systemYellow
            ratingStackView.addArrangedSubview(imageView)
        }
        
        let reminder = star.truncatingRemainder(dividingBy: 1)
        if reminder >= 0.5 {
            let starHalf = UIImage(systemName: "star.leadinghalf.filled")
            let imageView = UIImageView(image: starHalf)
            imageView.tintColor = .systemYellow

            ratingStackView.addArrangedSubview(imageView)
        }
        
        if ratingStackView.arrangedSubviews.count != 5 {
            for _ in 1...(5-ratingStackView.arrangedSubviews.count) {
                let starEmpty = UIImage(systemName: "star")
                let imageView = UIImageView(image: starEmpty)
                imageView.tintColor = .systemYellow

                ratingStackView.addArrangedSubview(imageView)
            }
        }
    }
}
