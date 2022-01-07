//
//  ProductResponse.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import Foundation

struct ProductListResponse: Codable {
    let header: Header
    let filters: [String]
    let products: [Product]
}

struct Header: Codable {
    let headerTitle, headerDescription: String
}

struct Product: Codable {
    let name: String
    let id: Int
    let imageURL: String
    let available: Bool
    let releaseDate: Int
    let description, longDescription: String
    let rating: Double
    let price: Price
}

struct Price: Codable {
    let value: Double
    let currency: Currency
}

enum Currency: String, Codable {
    case eur = "EUR"
}

