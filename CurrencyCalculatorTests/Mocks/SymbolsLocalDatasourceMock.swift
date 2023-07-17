//
//  SymbolsLocalDatasourceMock.swift
//  CurrencyCalculatorTests
//
//  Created by Isaac Iniongun on 16/07/2023.
//

@testable import CurrencyCalculator

final class SymbolsLocalDatasourceMock: SymbolsLocalDatasourceProtocol {
    private var symbols = [DBSymbol]()
    var saveSymbolsCalled = false
    var getSymbolsCalled = false
    
    func saveSymbols(_ symbols: [DBSymbol]) {
        saveSymbolsCalled = true
        self.symbols = symbols
    }
    
    func getSymbols() -> [DBSymbol] {
        getSymbolsCalled = true
        return symbols
    }
    
}
