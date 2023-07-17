//
//  CalculatorViewMock.swift
//  CurrencyCalculatorTests
//
//  Created by Isaac Iniongun on 16/07/2023.
//

@testable import CurrencyCalculator

final class CalculatorViewMock: CalculatorViewProtocol {
    var showLoadingAnimationCalled = false
    var errorMessage = ""
    var toastType = ToastType.success
    var conversionResult = ""
    var showConversionResultCalled = false
    var symbol: DBSymbol? = nil
    var didChooseSymbolCalled = false
    
    func showLoadingAnimation(_ show: Bool) {
        showLoadingAnimationCalled = true
    }
    
    func showError(_ message: String, type: ToastType) {
        errorMessage = message
        toastType = type
    }
    
    func showConversionResult(_ value: String) {
        showConversionResultCalled = true
        conversionResult = value
    }
    
    func didChooseSymbol(_ symbol: DBSymbol) {
        didChooseSymbolCalled = true
        self.symbol = symbol
    }
    
}
