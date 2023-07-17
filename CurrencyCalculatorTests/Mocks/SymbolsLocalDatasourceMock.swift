//
//  SymbolsLocalDatasourceMock.swift
//  CurrencyCalculatorTests
//
//  Created by Isaac Iniongun on 16/07/2023.
//

@testable import CurrencyCalculator

final class SymbolsLocalDatasourceMock: SymbolsLocalDatasourceProtocol {
    private var symbols = [DBSymbol]()
    
    func saveSymbols(_ symbols: [DBSymbol]) {
        self.symbols = symbols
    }
    
    func getSymbols() -> [DBSymbol] {
        return symbols
    }
    
}
