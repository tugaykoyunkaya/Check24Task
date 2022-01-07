//
//  ProductListViewModel.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import Foundation

final class ProductListViewModel: BaseViewModel {
    
    private let apiManager = APIManager()

    func getProdcut() {
        apiManager.fetchData(with: ApiEndPoints.productList.url) { [weak self] (response: Result<ProductListResponse, Error>) in
            guard let self = self else {
                return
            }
            switch response {
            case .success(let response):
                print(response.products)
            case .failure(let error):
                // TODO: Handle error case
                print(error)
            }
        }
    }
}
