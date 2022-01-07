//
//  ProductListViewModel.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import Foundation

final class ProductListViewModel: BaseViewModel {
    
    private let apiManager = APIManager()
    private var productList = [Product]()
    @Published private(set) var displayedProductList = [Product]()
    private(set) var headerSection: Header?

    func getProdcut() {
        apiManager.fetchData(with: ApiEndPoints.productList.url) { [weak self] (response: Result<ProductListResponse, Error>) in
            guard let self = self else {
                return
            }
            switch response {
            case .success(let response):
                self.headerSection = response.header
                self.productList = response.products
                self.displayedProductList = self.productList
            case .failure(let error):
                // TODO: Handle error case
                print(error)
            }
        }
    }
    
    func filterData(index: Int) {
        switch index {
        case 0:
            displayedProductList = productList
        case 1:
            availableData()
        case 2:
            favouriteData()

        default:
            break
        }
    }
    
    private func availableData() {
        let filtered = productList.filter { prodcut in
            return prodcut.available == true
        }
        displayedProductList = filtered
    }
    
    private func favouriteData() {
        displayedProductList = productList.filter({ product in
            product.isFavourite
        })
    }
}
