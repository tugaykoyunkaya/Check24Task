//
//  ProductListViewController.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import UIKit
import Combine
import SafariServices

final class ProductListViewController: BaseViewController<ProductListViewModel> {

    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    @IBOutlet weak private var tableView: UITableView!
    
    private var subscribers = Set<AnyCancellable>()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Check24"
        setupTableView()
        bindObservables()
        segmentedControl.addTarget(self, action: #selector(ProductListViewController.indexChanged(_:)), for: .valueChanged)
        refreshControl.addTarget(self, action: #selector(ProductListViewController.refreshData(_:)), for: .valueChanged)
        viewModel.getProdcut()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProductAvailableTableViewCell", bundle: nil), forCellReuseIdentifier: "AvailableCell")
        tableView.register(UINib(nibName: "ProductDisableTableViewCell", bundle: nil), forCellReuseIdentifier: "DisableCell")
        tableView.register(ProductListTableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(ProductListFooterView.self, forHeaderFooterViewReuseIdentifier: "footer")
        tableView.sectionHeaderTopPadding = 0.0
        tableView.refreshControl = refreshControl
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        viewModel.filterData(index: segmentedControl.selectedSegmentIndex)
    }
    
    @objc private func refreshData(_ sender: Any) {
        segmentedControl.selectedSegmentIndex = 0
        viewModel.getProdcut()
    }
    
    private func bindObservables() {
        viewModel.$displayedProductList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }.store(in: &subscribers)
    }
    
    private func navigateDetailPage(product: Product) {
        let viewModel = ProductDetailViewModel(product: product)
        viewModel.isFavouriteChanged.sink { [weak self] _ in
            guard let self = self else {
                return
            }
            self.viewModel.filterData(index: self.segmentedControl.selectedSegmentIndex)
        }.store(in: &subscribers)
        let controller = ProductDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func navigateFooterPage(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        navigationController?.present(safariVC, animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateDetailPage(product: viewModel.displayedProductList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:  "header") as! ProductListTableHeader
        guard let headerSection = viewModel.headerSection else {
            return nil
        }
        header.configure(firstText: headerSection.headerTitle, secendText: headerSection.headerDescription)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = viewModel.headerSection else {
            return 0
        }
        return 56
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier:  "footer") as! ProductListFooterView
        footer.configure(text: "© 2016 Check24") { [weak self] in
            guard let self = self else {
                return
            }
            self.navigateFooterPage(url: "https://m.check24.de/rechtliche-hinweise/?deviceoutput=app")
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 32
    }
}
