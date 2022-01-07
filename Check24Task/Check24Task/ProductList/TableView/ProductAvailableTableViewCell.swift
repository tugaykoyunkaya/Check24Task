//
//  ProductAvailableTableViewCell.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import UIKit
import Kingfisher

class ProductAvailableTableViewCell: UITableViewCell {

    @IBOutlet private weak var itemImage: UIImageView!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var starView: UIStackView!
    @IBOutlet private weak var secondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(item: Product) {
        // TODO: image set
        date.text = String(item.releaseDate.getDate())
        name.text = item.name
        secondLabel.text = item.description
        price.text = item.price.getPrice()
        guard let url = URL(string: item.imageURL) else {
            return
        }
        itemImage.kf.setImage(with: url)
    }
}

extension Price {
    func getPrice() -> String {
        String(format: "%.2f \(self.currency.rawValue)", self.value)
    }
}

extension Int {
    func getDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.YYYY"

        return dateFormatter.string(from: date)
    }
}

