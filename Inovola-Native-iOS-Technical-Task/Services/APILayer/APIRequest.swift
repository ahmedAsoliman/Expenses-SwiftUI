//
//  APIRequest.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 19/08/2025.
//
import Foundation

protocol APIRequest {
    associatedtype Response: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension APIRequest {
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }
}
