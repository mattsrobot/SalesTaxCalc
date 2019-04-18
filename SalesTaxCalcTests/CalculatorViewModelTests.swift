//
//  CalculatorViewModelTests.swift
//  SalesTaxCalcTests
//
//  Created by Matthew Wilkinson on 18/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import XCTest
@testable import SalesTaxCalc

class CalculatorViewModelTests: XCTestCase {

    func testAddingIncorrectProduct() {
        // GIVEN a view model with a valid state
        let viewModel = CalculatorViewModel(productLabel: "Apple", price: 10, quantity: 1)
        // WHEN user removes the product label
        viewModel.productLabel = nil
        // THEN the view model should not allow adding the product
        XCTAssert(viewModel.rightButtonEnabled == false)
        XCTAssert(viewModel.ticket == nil)
    }
    
    func testAddingCorrectProduct() {
        // GIVEN a view model with an invalid state
        let viewModel = CalculatorViewModel(productLabel: nil, price: 10, quantity: 1)
        // WHEN user adds the product label
        viewModel.productLabel = "Apple"
        // THEN the view model should not allow adding the product
        XCTAssert(viewModel.rightButtonEnabled == true)
        let ticket = viewModel.ticket
        XCTAssert(ticket != nil)
        XCTAssert(ticket?.label == "Apple")
        XCTAssert(ticket?.quantity == 1)
        XCTAssert(ticket?.price == 10)
    }
    
}
