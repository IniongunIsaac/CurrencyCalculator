//
//  ConversionResponse.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

struct ConversionResponse: Codable {
    let success: Bool?
    let timestamp: Int?
    let base, date: String?
    let rates: [String: Double]?
}
