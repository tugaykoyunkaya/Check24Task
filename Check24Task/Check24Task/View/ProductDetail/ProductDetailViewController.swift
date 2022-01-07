//
//  ProductDetailViewController.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import UIKit
import SafariServices

final class ProductDetailViewController: BaseViewController<ProductDetailViewModel> {

    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var price: UILabel!
    @IBOutlet weak private var ratingStackView: UIStackView!
    @IBOutlet weak private var date: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var detail: UILabel!
    @IBOutlet weak private var favourite: UIButton!
    
    @IBAction func favouriteClick(_ sender: Any) {
        let id = viewModel.product.id
        if UserDefaults.standard.isFavourite(id: id) {
            UserDefaults.standard.deleteFavourite(id: id)
        } else {
            UserDefaults.standard.addFavourite(id: id)
        }
        setNameColor()
        viewModel.isFavouriteChanged.send()
        let buttonTitle = UserDefaults.standard.isFavourite(id: viewModel.product.id) ? "Vergessen" : "Vormerken"
        favourite.setTitle(buttonTitle, for: .normal)
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
        configure()
    }
    
    private func configure() {
        let buttonTitle = UserDefaults.standard.isFavourite(id: viewModel.product.id) ? "Vergessen" : "Vormerken"
        favourite.setTitle(buttonTitle, for: .normal)
        
        name.text = viewModel.product.name
        price.text = viewModel.product.priceFormatted
        date.text = viewModel.product.dateFormatted
        descriptionLabel.text = viewModel.product.description
        detail.text = viewModel.product.longDescription
        setStar(star: viewModel.product.rating)
        setNameColor()
        guard let url = URL(string: viewModel.product.imageURL) else {
            return
        }
        imageView.kf.setImage(with: url)
    }
    
    private func setNameColor(){
        name.textColor = UserDefaults.standard.isFavourite(id: viewModel.product.id) ? .blue : .black
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
