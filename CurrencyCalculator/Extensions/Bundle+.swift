//
//  Bundle+.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import UIKit

extension Bundle {
    
    func value<T>(for key: String) -> T? {
        object(forInfoDictionaryKey: key) as? T
    }
    
    var baseURL: String { value(for: "BASE_URL")! }
    
    var accessKey: String { value(for: "ACCESS_KEY")! }
    
}
