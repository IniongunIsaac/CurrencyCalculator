//
//  CalculatorViewModelTests.swift
//  CurrencyCalculatorTests
//
//  Created by Isaac Iniongun on 16/07/2023.
//

import XCTest
@testable import CurrencyCalculator

final class CalculatorViewModelTests: XCTestCase {
    
    private var symbolsLocalDatasource: SymbolsLocalDatasourceMock!
    private var calculatorRemoteDatasource: CalculatorRemoteDatasourceMock!
    private var viewProtocol: CalculatorViewMock!
    
    private var viewModel: CalculatorViewModel!
    
    private let sampleSymbols = Array(repeating: DBSymbol.testStub, count: 10)

    override func setUpWithError() throws {
        viewProtocol = CalculatorViewMock()
        symbolsLocalDatasource = SymbolsLocalDatasourceMock()
        calculatorRemoteDatasource = CalculatorRemoteDatasourceMock()
        
        viewModel = CalculatorViewModel(
            symbolsLocalDatasource: symbolsLocalDatasource,
            calculatorRemoteDatasource: calculatorRemoteDatasource
        )
        
        viewModel.viewProtocol = viewProtocol
    }

    override func tearDownWithError() throws {
        viewProtocol = nil
        symbolsLocalDatasource = nil
        calculatorRemoteDatasource = nil
        viewModel = nil
    }

    func testSymbolsCacheEmptyOnInitialization() {
        viewModel.getSymbols()
        
        XCTAssertTrue(viewModel.symbols.isEmpty, "Symbols should be empty upon initialization")
    }
    
    func testGetSymbolsShowsLoadingAnimationOnView() {
        viewModel.getSymbols()
        XCTAssertTrue(viewProtocol.showLoadingAnimationCalled, "loading animation should be shown on the view")
    }
    
    func testGetSymbolsCallsRemoteDatasourceWhenLocalCacheIsEmpty() {
        viewModel.getSymbols()
        XCTAssertTrue(calculatorRemoteDatasource.getSymbolsCalled, "remote datasource should be called when there are no symbols in the cache")
    }
    
    func testGetSymbolsDoesNotCallRemoteDatasourceWhenCacheIsNotEmpty() {
        symbolsLocalDatasource.saveSymbols(sampleSymbols)
        
        viewModel.getSymbols()
        
        XCTAssertTrue(!viewModel.symbols.isEmpty, "view model symbols should be initialised from cache")
        XCTAssertFalse(calculatorRemoteDatasource.getSymbolsCalled, "remote datasource should not be called when we have symbols in the cache")
    }
    
    func testGetSymbolsFetchesFromRemoteAndCachesLocally() throws {
        calculatorRemoteDatasource.symbolsResponse = try SymbolsResponse.mapFrom(jsonString: ResponseString.symbolsResponse)
        
        viewModel.getSymbols()
        
        let dbSymbols = symbolsLocalDatasource.getSymbols()
        
        XCTAssertTrue(symbolsLocalDatasource.saveSymbolsCalled, "save symbols should be called to cache remote symbols")
        XCTAssertTrue(!dbSymbols.isEmpty, "cached symbols should not be empty")
        XCTAssertTrue(!viewModel.symbols.isEmpty, "view model symbols should not be empty")
    }
    
    func testGetSymbolsShowsErrorOnUIWhenResponseIsInvalid() {
        calculatorRemoteDatasource.symbolsResponse = nil
        
        viewModel.getSymbols()
        
        XCTAssertEqual(viewProtocol.errorMessage, "Unable to get initialization data", "show error should be called on view with the appropriate message")
        XCTAssertEqual(viewProtocol.toastType, .error, "toast type shown on the UI should be '.error'")
    }
    
    func testConvertShowsErrorOnUIWhenAmountIsNotValid() {
        viewModel.convert(amount: "")
        
        XCTAssertEqual(viewProtocol.errorMessage, "Please enter an EUR amount to convert", "an error should be shown on the UI when an invalid amount is supplied")
        XCTAssertEqual(viewProtocol.toastType, .error, "toast type shown on the UI should be '.error'")
    }
    
    func testConvertShowsErrorOnUIWhenNoSymbolIsSelected() {
        viewModel.convert(amount: "10")
        
        XCTAssertEqual(viewProtocol.errorMessage, "Please choose a currency", "an error should be shown on the UI when the user has not selected a currency")
        XCTAssertEqual(viewProtocol.toastType, .error, "toast type shown on the UI should be '.error'")
    }
    
    func testConvertShowsLoadingAnimationOnUI() {
        viewModel.updateSelectedSymbol(.testStub)
        viewModel.convert(amount: "10")
        
        XCTAssertTrue(viewProtocol.showLoadingAnimationCalled, "loading animation should be shown on the UI")
    }
    
    func testConvertCallsRemoteDatasourceToGetRates() {
        viewModel.updateSelectedSymbol(.testStub)
        viewModel.convert(amount: "10")
        
        XCTAssertTrue(calculatorRemoteDatasource.getRatesCalled, "remote datasource should be called to get rates")
    }
    
    func testConvertShowsErrorOnUIWhenResponseIsInvalid() {
        calculatorRemoteDatasource.conversionResponse = nil
        viewModel.updateSelectedSymbol(.testStub)
        viewModel.convert(amount: "10")
        
        XCTAssertEqual(viewProtocol.errorMessage, "Unable to get conversion data, please try again", "an error should be shown on the UI when the conversion fails")
        XCTAssertEqual(viewProtocol.toastType, .error, "toast type shown on the UI should be '.error'")
    }
    
    func testConvertShowsConversionResultOnUI() throws {
        calculatorRemoteDatasource.conversionResponse = try ConversionResponse.mapFrom(jsonString: ResponseString.conversionResponse)
        viewModel.updateSelectedSymbol(.testStub)
        viewModel.convert(amount: "10")
        
        XCTAssertTrue(viewProtocol.showConversionResultCalled, "showConversionResult should be called on the UI")
        XCTAssertTrue(!viewProtocol.conversionResult.isEmpty, "conversion result should be shown on the UI")
    }
    
    func testUpdateSelectedSymbolUpdatesUI() {
        viewModel.updateSelectedSymbol(.testStub)
        
        XCTAssertTrue(viewProtocol.symbol != nil, "The UI should be updated with a valid symbol")
        XCTAssertTrue(viewProtocol.didChooseSymbolCalled, "didChooseSymbol should be called on the view for updates")
    }

}
