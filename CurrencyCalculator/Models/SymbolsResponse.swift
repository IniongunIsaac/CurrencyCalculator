//
//  SymbolsResponse.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 12/07/2023.
//

import Foundation

struct SymbolsResponse: Codable {
    let success: Bool?
    let symbols: [String: String]?
}
