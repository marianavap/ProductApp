//
//  ProductAppTests.swift
//  ProductAppTests
//
//  Created by Mariana Souza on 20/01/2025.
//

import XCTest
import Combine
@testable import ProductApp

final class ProductViewModelTests: XCTestCase {
    var viewModel: ProductViewModel!
    var mockAPIClient: MockAPIClient!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        viewModel = ProductViewModel(apiClient: mockAPIClient)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockAPIClient = nil
        cancellables = nil
        super.tearDown()
    }

    func testLoadProducts_Success() {
        let mockProducts = [
            Product(
                id: 1,
                title: "Mock Product",
                description: "Mock Description",
                category: .furniture,
                price: 99.99,
                discountPercentage: 10.0,
                rating: 4.5,
                stock: 20,
                tags: ["mock", "test"],
                brand: "MockBrand",
                sku: "12345",
                weight: 5,
                dimensions: Dimensions(width: 10, height: 10, depth: 10),
                warrantyInformation: "1 year",
                shippingInformation: "Ships in 3 days",
                availabilityStatus: .inStock,
                reviews: [],
                returnPolicy: .the30DaysReturnPolicy,
                minimumOrderQuantity: 1,
                meta: Meta(
                    createdAt: .the20240523T085621618Z,
                    updatedAt: .the20240523T085621619Z,
                    barcode: "1234567890",
                    qrCode: "mockQRCode"
                ),
                images: ["image1.png"],
                thumbnail: "thumb.png"
            )
        ]

        mockAPIClient.mockResponse = ProductValues(products: mockProducts, total: 1, skip: 0, limit: 10)

        let expectation = self.expectation(description: "Products loaded successfully")
        viewModel.loadProducts()

        viewModel.$products
            .dropFirst()
            .sink { products in
                XCTAssertEqual(products.count, 1)
                XCTAssertEqual(products.first?.title, "Mock Product")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadProducts_Failure() {
        mockAPIClient.mockError = URLError(.badServerResponse)

        let expectation = self.expectation(description: "Error handled correctly")
        
        // Call the function to load products
        viewModel.loadProducts()

        // Ensure that we handle only the first error emitted
        viewModel.$errorMessage
            .dropFirst()
            .first() // Only process the first error
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Failed to load products: The operation couldn’t be completed. (NSURLErrorDomain error -1.)")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 1, handler: nil)
    }

}
