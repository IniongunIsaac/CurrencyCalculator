//
//  CalculatorViewMock.swift
//  CurrencyCalculatorTests
//
//  Created by Isaac Iniongun on 16/07/2023.
//

@testable import CurrencyCalculator

final class CalculatorViewMock: CalculatorViewProtocol {
    var loadingAnimationVisible = false
    var errorMessage = ""
    var toastType = ToastType.success
    var conversionResult = ""
    var symbol: DBSymbol? = nil
    
    func showLoadingAnimation(_ show: Bool) {
        loadingAnimationVisible = show
    }
    
    func showError(_ message: String, type: ToastType) {
        errorMessage = message
        toastType = type
    }
    
    func showConversionResult(_ value: String) {
        conversionResult = value
    }
    
    func didChooseSymbol(_ symbol: DBSymbol) {
        self.symbol = symbol
    }
    
}
