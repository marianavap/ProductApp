//
//  MockAPIClient.swift
//  ProductApp
//
//  Created by Mariana Souza on 20/01/2025.
//

import Foundation
import Combine
@testable import ProductApp

final class MockAPIClient: APIClientProtocol {
    var mockResponse: Any?
    var mockError: Error?

    func fetch<T: Decodable>(url: String, responseType: T.Type) -> AnyPublisher<T, Error> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }

        if let response = mockResponse as? T {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
    }
}
