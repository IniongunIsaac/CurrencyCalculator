//
//  CalculatorViewModelProtocol.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

protocol CalculatorViewModelProtocol {
    
    /// Interface to enhance communication with the View
    var viewProtocol: CalculatorViewProtocol? { get set }
    
    /// Available and supported symbols
    var symbols: [DBSymbol] { get }
    
    /// Retrieve supported symbols from local cache or remote server
    func getSymbols()
    
    
    /// Convert supplied amount from EUR to pre-selected currency
    /// - Parameter amount: the amount to convert
    func convert(amount: String)
    
    
    /// Set selected symbol from list of available symbols
    /// - Parameter dbSymbol: symbol to set
    func updateSelectedSymbol(_ dbSymbol: DBSymbol)
}
