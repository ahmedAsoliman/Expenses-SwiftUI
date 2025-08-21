//
//  Constants.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//

import Foundation
struct Constants {
    
    struct URLS {
        static let baseURL = "https://open.er-api.com/"
        static let  apiVersion: String = "v6/latest/"
        static func getCurrencyExchangeRate(for currency: String) -> URL? {
            return URL(string: baseURL+apiVersion+currency)
        }
    }

    
}
