//
//  ProductListFooterView.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import UIKit

final class ProductListFooterView: UITableViewHeaderFooterView {
    
    static let identifier = "FooterView"
    private var buttonAction: ( () -> Void)?
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(text: String, actionButtonClosure: @escaping () -> Void) {
        button.setTitle(text, for: .normal)
        buttonAction = actionButtonClosure
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }
    
    @objc func buttonAction (_ sender: UIButton!) {
        buttonAction?()
    }
}
