//
//  CalculatorViewModel.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 14/07/2023.
//

import Foundation

final class CalculatorViewModel: CalculatorViewModelProtocol {
    
    var symbolsLocalDatasource: SymbolsLocalDatasourceProtocol
    var calculatorRemoteDatasource: CalculatorRemoteDatasourceProtocol
    
    init(
        symbolsLocalDatasource: SymbolsLocalDatasourceProtocol,
        calculatorRemoteDatasource: CalculatorRemoteDatasourceProtocol
    ) {
        self.symbolsLocalDatasource = symbolsLocalDatasource
        self.calculatorRemoteDatasource = calculatorRemoteDatasource
    }
    
    private(set) var symbols: [DBSymbol] = []
    weak var viewProtocol: CalculatorViewProtocol?
    private var selectedSymbol: DBSymbol?
    
    /// Initialise symbols from local cache or remote datasource
    func getSymbols() {
        let dbSymbols = symbolsLocalDatasource.getSymbols()
        if dbSymbols.isEmpty {
            getRemoteSymbols()
        } else {
            symbols = dbSymbols.sorted { $0.name < $1.name }
        }
    }
    
    /// Fetch currencies from remote datasource
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
    
    /// Maps symbols response from the server into a DB Model and asks the LocalDatasource to cache
    /// - Parameter response: Model received from the server
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
    
    func convert(amount: String) {
        guard (Double(amount) ?? 0) > 1 else {
            viewProtocol?.showError("Please enter an EUR amount to convert", type: .error)
            return
        }
        
        guard let symbol = selectedSymbol?.code else {
            viewProtocol?.showError("Please choose a currency", type: .error)
            return
        }
        
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
    
    /// Manipulates `ConversionResponse` gotten from the server and asks the ViewProtocol
    /// to update the UI with the result
    /// - Parameters:
    ///   - response: `ConversionResponse` retrieved from the server
    ///   - amount: amount supplied by the user to convert
    ///   - symbol: currency to convert amount to
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
    
    func updateSelectedSymbol(_ dbSymbol: DBSymbol) {
        selectedSymbol = dbSymbol
        viewProtocol?.didChooseSymbol(dbSymbol)
    }
}
