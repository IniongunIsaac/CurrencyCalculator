//
//  CalculatorRemoteDatasourceProtocol.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

protocol CalculatorRemoteDatasourceProtocol {
    func getSymbols(completion: ResultAction<SymbolsResponse>?)
    
    func getRates(symbol: String, completion: ResultAction<ConversionResponse>?)
}
