//
//  CalculatorRemoteDatasource.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

final class CalculatorRemoteDatasource: BaseRemoteDatasource, CalculatorRemoteDatasourceProtocol {
    func getSymbols(completion: ResultAction<SymbolsResponse>?) {
        makeRequest(
            returnType: SymbolsResponse.self,
            path: .symbols,
            completion: completion
        )
    }
    
    func getRates(symbol: String, completion: ResultAction<ConversionResponse>?) {
        makeRequest(
            returnType: ConversionResponse.self,
            path: .latest,
            params: ["symbols" : symbol],
            completion: completion
        )
    }
}
