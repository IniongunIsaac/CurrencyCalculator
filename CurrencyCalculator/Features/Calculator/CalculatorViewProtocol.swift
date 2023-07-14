//
//  CalculatorViewProtocol.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

protocol CalculatorViewProtocol {
    func showLoadingAnimation(_ show: Bool)
    func showError(_ message: String, type: ToastType)
    func showConversionResult(_ value: String)
}
