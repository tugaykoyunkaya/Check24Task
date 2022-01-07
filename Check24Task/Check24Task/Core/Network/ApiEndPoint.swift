//
//  ApiEndPoint.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import Foundation

enum ApiEndPoints: String {
    case productList = "http://app.check24.de/products-test.json"

    var url: URL{
        URL(string: self.rawValue)!
    }
    
    var urlString: String{
        self.rawValue
    }
}
