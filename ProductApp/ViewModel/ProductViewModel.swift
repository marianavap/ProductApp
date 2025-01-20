//
//  ProductViewModel.swift
//  ProductApp
//
//  Created by Mariana Souza on 20/01/2025.
//

import Combine
import SwiftUI

final class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
        loadProducts()
    }

    func loadProducts() {
        isLoading = true
        errorMessage = nil

        apiClient.fetch(url: "https://dummyjson.com/products", responseType: ProductValues.self)
            .map { $0.products }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = "Failed to load products: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] products in
                self?.products = products
            }
            .store(in: &cancellables)
    }
}
