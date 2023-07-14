//
//  RemotePath.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

enum RemotePath {
    case symbols
    case latest
    
    var requestURL: String {
        let baseURL = Bundle.main.baseURL
        let accessKey = Bundle.main.accessKey
        
        switch self {
        case .symbols:
            return "\(baseURL)symbols?access_key=\(accessKey)"
        case .latest:
            return "\(baseURL)latest?access_key=\(accessKey)"
        }
    }
    
}
