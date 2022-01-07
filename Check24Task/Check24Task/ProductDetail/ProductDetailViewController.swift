//
//  ProductDetailViewController.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import UIKit
import SafariServices

final class ProductDetailViewController: BaseViewController<ProductDetailViewModel> {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var favourite: UIButton!
    
    @IBAction func favouriteClick(_ sender: Any) {
        let id = viewModel.product.id
        if UserDefaults().isFavourite(id: id) {
            UserDefaults().deleteFavourite(id: id)
        } else {
            UserDefaults().addFavourite(id: id)
        }
        favourite.setTitle(UserDefaults().isFavourite(id: viewModel.product.id) ? "Vergessen" : "Vormerken", for: .normal)
    }
    
    @IBAction func footerClick(_ sender: Any) {
        guard let url = URL(string: "https://m.check24.de/rechtliche-hinweise/?deviceoutput=app") else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        navigationController?.present(safariVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Check24"
        favourite.setTitle(UserDefaults().isFavourite(id: viewModel.product.id) ? "Vergessen" : "Vormerken", for: .normal)

        configure()
    }
    
    private func configure() {
        name.text = viewModel.product.name
        price.text = viewModel.product.price.getPrice()
        date.text = viewModel.product.releaseDate.getDate()
        descriptionLabel.text = viewModel.product.description
        detail.text = viewModel.product.longDescription
        guard let url = URL(string: viewModel.product.imageURL) else {
            return
        }
        imageView.kf.setImage(with: url)
    }
}
