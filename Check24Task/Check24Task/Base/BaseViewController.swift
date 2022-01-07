//
//  BaseViewController.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController {
    var viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: Self.className, bundle: Self.bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension NSObject {
    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
    
    static var className: String {
        return String(describing: Self.self)
    }
}

