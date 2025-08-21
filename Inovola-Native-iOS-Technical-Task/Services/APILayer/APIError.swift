//
//  APIError.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 19/08/2025.
//

import Foundation
enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Int)
    case noData
    case decodingFailed
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .requestFailed(let status): return "Request failed with status code: \(status)"
        case .noData: return "No data returned"
        case .decodingFailed: return "Decoding response failed"
        case .unknown(let error): return error.localizedDescription
        }
    }
}
