//
//  CurrencyConverterService.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//

import Foundation

 class CurrencyConverterService {
    func convertToUSD(amount: Double, from currency: String) async throws -> Double {
        guard currency != "USD" else { return amount }

        let api = APIManger(baseURL: Constants.URLS.getCurrencyExchangeRate(for: "USD")!)

 
 
        let request = ExchangRateRequest()

        do {
            let result = try await api.execute(request)
            guard let rate = result.rates?[currency] else {
                throw NSError(domain: "Currency not found", code: 404)
            }
            
                   return amount / rate
        } catch {
//            errorMessage = error.localizedDescription
            print("❌ Error: \(error.localizedDescription)")
        }
        return amount
    }
}

 
