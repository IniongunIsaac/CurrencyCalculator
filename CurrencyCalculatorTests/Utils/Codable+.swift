//
//  Codable+.swift
//  CurrencyCalculatorTests
//
//  Created by Isaac Iniongun on 17/07/2023.
//

import Foundation

extension Decodable {
    static func mapFrom(jsonString: String) throws -> Self? {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: Data(jsonString.utf8))
    }
}
