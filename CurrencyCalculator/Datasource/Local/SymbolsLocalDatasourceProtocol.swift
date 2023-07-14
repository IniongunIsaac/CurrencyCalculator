//
//  SymbolsLocalDatasourceProtocol.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

protocol SymbolsLocalDatasourceProtocol {
    func saveSymbols(_ symbols: [DBSymbol])
    func getSymbols() -> [DBSymbol]
}
