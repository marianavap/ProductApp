//
//  Review.swift
//  ProductApp
//
//  Created by Mariana Souza on 20/01/2025.
//

struct Review: Codable {
    let rating: Int
    let comment: String
    let date: CreatedAt
    let reviewerName, reviewerEmail: String
}
