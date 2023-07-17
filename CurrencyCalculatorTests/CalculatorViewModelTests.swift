//
//  CalculatorViewModelTests.swift
//  CurrencyCalculatorTests
//
//  Created by Isaac Iniongun on 16/07/2023.
//

import XCTest
@testable import CurrencyCalculator

final class CalculatorViewModelTests: XCTestCase {
    
    private var viewProtocol: CalculatorViewProtocol!
    
    private var viewModel: CalculatorViewModel!

    override func setUpWithError() throws {
        DependencyContainer.setupDependencies()
        viewProtocol = CalculatorViewMock()
        viewModel = CalculatorViewModel()
        viewModel.viewProtocol = viewProtocol
    }

    override func tearDownWithError() throws {
        viewProtocol = nil
        viewModel = nil
    }

    func testSymbolsCacheEmptyOnInitialization() throws {
        viewModel.getSymbols()
        
        XCTAssertTrue(viewModel.symbols.isEmpty, "Symbols should be empty upon initialization")
    }

}
