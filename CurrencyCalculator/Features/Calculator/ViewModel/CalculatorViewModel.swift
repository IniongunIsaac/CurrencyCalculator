//
//  CalculatorViewModel.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

final class CalculatorViewModel: CalculatorViewModelProtocol {
    
    @Provided var symbolsLocalDatasource: SymbolsLocalDatasourceProtocol
    @Provided var calculatorRemoteDatasource: CalculatorRemoteDatasourceProtocol
    
    private(set) var symbols: [DBSymbol] = []
    var viewProtocol: CalculatorViewProtocol?
    
    func getSymbols() {
        let dbSymbols = symbolsLocalDatasource.getSymbols()
        if dbSymbols.isEmpty {
            getRemoteSymbols()
        } else {
            symbols = dbSymbols
        }
    }
    
    private func getRemoteSymbols() {
        viewProtocol?.showLoadingAnimation(true)
        calculatorRemoteDatasource.getSymbols { [weak self] result in
            self?.viewProtocol?.showLoadingAnimation(false)
            switch result {
            case let .success(symbolsResponse):
                self?.didGetRemoteSymbols(response: symbolsResponse)
            case let .failure(error):
                _print(error, .error)
                self?.viewProtocol?.showError("Unable to get initialization data", type: .error)
            }
        }
    }
    
    private func didGetRemoteSymbols(response: SymbolsResponse) {
        if let remoteSymbols = response.symbols, !remoteSymbols.isEmpty {
            let dbSymbols = remoteSymbols.map { code, name in
                return DBSymbol(code: code, name: name)
            }
            symbolsLocalDatasource.saveSymbols(dbSymbols)
            self.symbols = dbSymbols
        } else {
            viewProtocol?.showError("Unable to get initialization data", type: .error)
        }
    }
    
    func convert(amount: String, symbol: String) {
        viewProtocol?.showLoadingAnimation(true)
        calculatorRemoteDatasource.getRates(symbol: symbol) { [weak self] result in
            self?.viewProtocol?.showLoadingAnimation(false)
            switch result {
            case let .success(conversionResponse):
                self?.didGetConversionData(conversionResponse, amount: amount, symbol: symbol)
            case let .failure(error):
                _print(error, .error)
                self?.viewProtocol?.showError("Unable to get conversion data, please try again", type: .error)
            }
        }
    }
    
    private func didGetConversionData(
        _ response: ConversionResponse,
        amount: String,
        symbol: String
    ) {
        if let rateDict = response.rates,
           let rateValue = rateDict[symbol],
           let amountValue = Double(amount)
        {
            let conversionResult = rateValue * amountValue
            viewProtocol?.showConversionResult(String(conversionResult))
        } else {
            viewProtocol?.showError("Unable to get conversion data, please try again", type: .error)
        }
    }
}
