//
//  CalculatorRemoteDatasourceMock.swift
//  CurrencyCalculatorTests
//
//  Created by Isaac Iniongun on 16/07/2023.
//

@testable import CurrencyCalculator

final class CalculatorRemoteDatasourceMock: CalculatorRemoteDatasourceProtocol {
    var symbolsResponse: SymbolsResponse? = nil
    var conversionResponse: ConversionResponse? = nil
    var getSymbolsCalled = false
    var getRatesCalled = false
    
    func getSymbols(completion: ResultAction<SymbolsResponse>?) {
        getSymbolsCalled = true
        if let symbolsResponse {
            completion?(.success(symbolsResponse))
        } else {
            completion?(.failure(.custom("Something went wrong")))
        }
    }
    
    func getRates(symbol: String, completion: ResultAction<ConversionResponse>?) {
        getRatesCalled = true
        if let conversionResponse {
            completion?(.success(conversionResponse))
        } else {
            completion?(.failure(.custom("Something went wrong")))
        }
    }
    
}
