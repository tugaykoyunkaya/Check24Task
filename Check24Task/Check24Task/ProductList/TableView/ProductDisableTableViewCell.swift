//
//  ProductDiasableTableViewCell.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import UIKit
import Kingfisher

class ProductDisableTableViewCell: UITableViewCell {

    @IBOutlet weak private var itemImage: UIImageView!
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var starView: UIStackView!
    @IBOutlet weak private var secondLabel: UILabel!


    func configure(item: Product) {
        name.text = item.name
        secondLabel.text = item.description
        guard let url = URL(string: item.imageURL) else {
            return
        }
        itemImage.kf.setImage(with: url)
    }
    
}
