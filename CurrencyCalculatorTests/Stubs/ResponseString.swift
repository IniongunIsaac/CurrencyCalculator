//
//  ResponseConstants.swift
//  CurrencyCalculatorTests
//
//  Created by Isaac Iniongun on 17/07/2023.
//

import Foundation

enum ResponseString {
    static let symbolsResponse = """
        {
              "success": true,
              "symbols": {
                    "AED": "United Arab Emirates Dirham",
                    "AFN": "Afghan Afghani",
                    "ALL": "Albanian Lek",
                    "AMD": "Armenian Dram"
              }
        }
    """
    
    static let conversionResponse = """
        {
            "success": true,
            "timestamp": 1519296206,
            "base": "USD",
            "date": "2023-07-12",
            "rates": {
                "GBP": 0.72007,
                "JPY": 107.346001,
                "EUR": 0.813399,
                "NGN": 797.88
            }
        }
    """
    
}
