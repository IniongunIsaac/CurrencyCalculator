//
//  ModelDecodingTests.swift
//  CurrencyCalculatorTests
//
//  Created by Isaac Iniongun on 17/07/2023.
//

import XCTest
@testable import CurrencyCalculator

final class ModelDecodingTests: XCTestCase {

    func testSymbolsResponse() throws {
        let response = try SymbolsResponse.mapFrom(jsonString: ResponseString.symbolsResponse)
        
        XCTAssertNotNil(response, "response should not be nil")
        XCTAssertTrue(response!.success!, "success should be true")
        XCTAssertNotNil(response?.symbols, "symbols should not be nil")
        XCTAssertEqual(response!.symbols!.count, 4, "there should be 4 symbols present in the response")
    }
    
    func testConversionResponse() throws {
        let response = try ConversionResponse.mapFrom(jsonString: ResponseString.conversionResponse)
        
        XCTAssertNotNil(response, "response should not be nil")
        XCTAssertTrue(response!.success!, "success should be true")
        XCTAssertEqual(response?.base, "USD", "base should be EUR")
        XCTAssertNotNil(response?.rates, "rates should not be nil")
        XCTAssertEqual(response?.rates?["EUR"], 0.813399, "EUR rate should be equal to `0.813399`")
    }
    
    func testDecodingFailure() {
        XCTAssertThrowsError(try ConversionResponse.mapFrom(jsonString: ""), "decoding attempt should throw")
    }

}
