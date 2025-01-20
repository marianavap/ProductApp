//
//  APIClientTests.swift
//  ProductApp
//
//  Created by Mariana Souza on 20/01/2025.
//

import XCTest
@testable import ProductApp
import Combine

final class APIClientTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func testFetch_Success() {
        let mockResponse = ProductValues(products: [], total: 0, skip: 0, limit: 10)
        
        let mockAPIClient = MockAPIClient()
        mockAPIClient.mockResponse = mockResponse
        
        let expectation = self.expectation(description: "API fetch success")
        
        mockAPIClient.fetch(url: "mockURL", responseType: ProductValues.self)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure.")
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.total, 0)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetch_Failure() {
        let mockError = URLError(.badServerResponse)
        
        let mockAPIClient = MockAPIClient()
        mockAPIClient.mockError = mockError
        
        let expectation = self.expectation(description: "API fetch failure")
        
        mockAPIClient.fetch(url: "mockURL", responseType: ProductValues.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success.")
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
