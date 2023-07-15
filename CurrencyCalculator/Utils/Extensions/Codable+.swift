//
//  Codable+.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    
    var prettyJson: String {
        if let responseData = try? JSONSerialization.data(withJSONObject: self.dictionary, options: .prettyPrinted) {
            return String(data: responseData, encoding: .utf8) ?? ""
        }
        return ""
    }
    
}
