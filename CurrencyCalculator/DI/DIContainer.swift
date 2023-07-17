//
//  DIContainer.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 17/07/2023.
//

import Foundation

struct DIContainer {
    static func symbolsLocalDatasource() -> SymbolsLocalDatasourceProtocol {
        SymbolsLocalDatasource()
    }
    
    static func calculatorRemoteDatasource() -> CalculatorRemoteDatasourceProtocol {
        CalculatorRemoteDatasource()
    }
    
    static func calculatorViewModel() -> CalculatorViewModelProtocol {
        CalculatorViewModel(
            symbolsLocalDatasource: symbolsLocalDatasource(),
            calculatorRemoteDatasource: calculatorRemoteDatasource()
        )
    }
    
    static func calculatorViewController() -> CalculatorViewController {
        CalculatorViewController(viewModel: calculatorViewModel())
    }
}
