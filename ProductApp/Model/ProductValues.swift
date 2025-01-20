//
//  ProductValues.swift
//  ProductApp
//
//  Created by Mariana Souza on 20/01/2025.
//

import SwiftUI
import Combine

struct ProductValues: Codable {
    let products: [Product]
    let total, skip, limit: Int
}
