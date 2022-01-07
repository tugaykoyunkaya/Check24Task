//
//  ProductDetailViewModel.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import Foundation
import Combine

final class ProductDetailViewModel: BaseViewModel {
    let product: Product
    let isFavouriteChanged = PassthroughSubject<Void, Never>()

    init(product: Product) {
        self.product = product
    }
}
