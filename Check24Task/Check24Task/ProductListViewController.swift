//
//  ProductListViewController.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import UIKit

final class ProductListViewController: BaseViewController<ProductListViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    private func getData() {
        viewModel.getProdcut()
    }
}
