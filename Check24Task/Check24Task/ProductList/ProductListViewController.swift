//
//  ProductListViewController.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import UIKit
import Combine

final class ProductListViewController: BaseViewController<ProductListViewModel> {

    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    @IBOutlet weak private var tableView: UITableView!
    private var subscribers = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Check24"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProductAvailableTableViewCell", bundle: nil), forCellReuseIdentifier: "AvailableCell")
        tableView.register(UINib(nibName: "ProductDisableTableViewCell", bundle: nil), forCellReuseIdentifier: "DisableCell")
        tableView.sectionHeaderTopPadding = 0.0
        
        bindObservables()
        viewModel.getProdcut()
    }

    
    private func bindObservables() {
        viewModel.$displayedProductList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &subscribers)
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayedProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.displayedProductList[indexPath.row].available {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableCell", for: indexPath) as! ProductAvailableTableViewCell
            cell.configure(item: viewModel.displayedProductList[indexPath.row])
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DisableCell", for: indexPath) as! ProductDisableTableViewCell
            cell.configure(item: viewModel.displayedProductList[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
}
