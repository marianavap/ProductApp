//
//  ProductListView.swift
//  ProductApp
//
//  Created by Mariana Souza on 20/01/2025.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                } else {
                    List(viewModel.products) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductRowView(product: product)
                        }
                    }
                }
            }
            .navigationTitle("Products")
        }
    }
}

@main
struct ProductApp: App {
    var body: some Scene {
        WindowGroup {
            ProductListView()
        }
    }
}
