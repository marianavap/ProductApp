//
//  ProductDetailView.swift
//  ProductApp
//
//  Created by Mariana Souza on 20/01/2025.
//

import SwiftUI
import Combine

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)

                Text(product.title)
                    .font(.largeTitle)
                    .bold()

                Text("Category: \(product.category.rawValue.capitalized)")
                    .font(.headline)

                Text("Price: $\(String(format: "%.2f", product.price))")
                    .font(.title2)

                Text("Discount: \(String(format: "%.1f", product.discountPercentage))%")
                    .font(.title3)

                Text("Stock: \(product.stock)")
                    .font(.headline)

                Text("Dimensions: \(String(format: "%.1f", product.dimensions.width)) x \(String(format: "%.1f", product.dimensions.height)) x \(String(format: "%.1f", product.dimensions.depth))")
                    .font(.subheadline)

                Text("Description:")
                    .font(.headline)
                Text(product.description)
                    .font(.body)

                Spacer()
            }
            .padding()
            .navigationTitle("Product Detail")
        }
    }
}
