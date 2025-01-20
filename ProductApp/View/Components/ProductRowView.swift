//
//  ProductRowView.swift
//  ProductApp
//
//  Created by Mariana Souza on 20/01/2025.
//

import SwiftUI

struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack {
            Image(systemName: productIcon(for: product.rating))
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text("Rating: \(String(format: "%.1f", product.rating))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }

    private func productIcon(for rating: Double) -> String {
        switch rating {
        case ..<3: return "xmark.circle"
        case 3..<4: return "star"
        default: return "star.fill"
        }
    }
}
