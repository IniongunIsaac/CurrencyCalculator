//
//  Dependencies.swift
//  CurrencyCalculatorTests
//
//  Created by Isaac Iniongun on 16/07/2023.
//

@testable import CurrencyCalculator

extension DependencyContainer {
    static func setupDependencies() {
        invalidateCache()
        
        register(
            type: CalculatorRemoteDatasourceProtocol.self,
            factory: CalculatorRemoteDatasourceMock()
        )
        
        register(
            type: SymbolsLocalDatasourceProtocol.self,
            factory: SymbolsLocalDatasourceMock()
        )
        
        register(
            type: CalculatorViewProtocol.self,
            factory: CalculatorViewMock()
        )
    }
}
