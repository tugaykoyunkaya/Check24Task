//
//  ProductDetailViewModel.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import Foundation

final class ProductDetailViewModel: BaseViewModel {
    let product: Product

    init(product: Product) {
        self.product = product
    }
}
