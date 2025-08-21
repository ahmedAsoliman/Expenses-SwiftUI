//
//  APIManger.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 19/08/2025.
//

import Foundation
class APIManger {
    private let baseURL: URL
    private let session: URLSession

    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    func execute<T: APIRequest>(_ request: T) async throws -> T.Response {
//        guard var components = URLComponents(url: baseURL.appendingPathComponent(request.path), resolvingAgainstBaseURL: true) else {
            guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            throw APIError.invalidURL
        }

        components.queryItems = request.queryItems

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        request.headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }

        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.noData
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.requestFailed(httpResponse.statusCode)
            }

            do {
                return try JSONDecoder().decode(T.Response.self, from: data)
            } catch {
                throw APIError.decodingFailed
            }
        } catch {
            throw APIError.unknown(error)
        }
    }
}
