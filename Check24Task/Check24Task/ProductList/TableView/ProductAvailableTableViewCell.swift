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
    @IBOutlet private weak var starView: UIStackView!
    @IBOutlet private weak var secondLabel: UILabel!

    func configure(item: Product) {
        date.text = item.dateFormatted
        name.text = item.name
        secondLabel.text = item.description
        price.text = item.priceFormatted
        guard let url = URL(string: item.imageURL) else {
            return
        }
        itemImage.kf.setImage(with: url)
    }
}
