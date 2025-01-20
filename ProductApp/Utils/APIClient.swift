//
//  APIClient.swift
//  ProductApp
//
//  Created by Mariana Souza on 20/01/2025.
//

import Foundation
import Combine

protocol APIClientProtocol {
    func fetch<T: Decodable>(url: String, responseType: T.Type) -> AnyPublisher<T, Error>
}

final class APIClient: APIClientProtocol {
    static let shared = APIClient()

    private init() {}

    func fetch<T: Decodable>(url: String, responseType: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
