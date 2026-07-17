//
//  APIClient.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import Foundation

protocol RequestProtocol {
    func request<T: Decodable>(target: RequestInfos) async throws -> (T) where T : Decodable
}

enum NetworkingError: Error {
    case noComponents
    case invalidResponse
    case invalidStatusCode(statusCode: Int)
}

class APIClient: RequestProtocol {
    let urlSession = URLSession.shared
    static let shared = APIClient()

    func request<T>(target: RequestInfos) async throws -> (T) where T : Decodable {
        let url = target.baseURL + target.endpoint
        guard var components = URLComponents(string: url) else { throw NetworkingError.noComponents }

        if let parameters = target.parameters {
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        }

        guard let requestUrl = components.url else { throw NetworkingError.noComponents }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = target.httpMethod.rawValue

        if let body = target.body {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        }

        let (data, response) = try await urlSession.data(for: request)

        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkingError.invalidStatusCode(statusCode: -1)
        }

        guard (200...299).contains(statusCode) else {
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }

        let responseValue = try JSONDecoder().decode(T.self, from: data)
        return responseValue
    }
}
