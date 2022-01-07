//
//  NSObject+Extension.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import Foundation

extension NSObject {
    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
    
    static var className: String {
        return String(describing: Self.self)
    }
}
