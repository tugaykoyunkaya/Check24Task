//
//  ProductDiasableTableViewCell.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import UIKit

class ProductDisableTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var starView: UIStackView!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(item: Product) {
        // TODO: iamge set
        name.text = item.name
        secondLabel.text = item.description

    }
    
}