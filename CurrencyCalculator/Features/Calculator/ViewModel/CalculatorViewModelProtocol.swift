//
//  CalculatorViewModelProtocol.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

protocol CalculatorViewModelProtocol {
    var viewProtocol: CalculatorViewProtocol? { get set }
    var symbols: [DBSymbol] { get }
    
    func getSymbols()
}
