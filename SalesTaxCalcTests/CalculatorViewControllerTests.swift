//
//  CalculatorViewCoordinatorTests.swift
//  SalesTaxCalcTests
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import XCTest
@testable import SalesTaxCalc

class CalculatorViewCoordinatorTests: XCTestCase {
    
    func testOutletsConnected() {
        let vm = CalculatorViewModel(productLabel: "Apple", price: 10, quantity: 1)
        let vc = CalculatorViewController(viewModel: vm)
        let _ = vc.view
        XCTAssert(vc.costTextField != nil)
        XCTAssert(vc.productLabelTextField != nil)
        XCTAssert(vc.quantityTextField != nil)
        XCTAssert(vc.scrollView != nil)
    }
    
    func testHandlingBadDataForCostField() {
        let vm = CalculatorViewModel(productLabel: "Apple", price: 10, quantity: 1)
        let vc = CalculatorViewController(viewModel: vm)
        let _ = vc.view
        vc.costTextField.text = "abc"
        vc.didUpdateTextField(vc.costTextField)
        XCTAssert(vm.price == 0)
    }
    
    func testHandlingBadDataForCostField2() {
        let vm = CalculatorViewModel(productLabel: "Apple", price: 10, quantity: 1)
        let vc = CalculatorViewController(viewModel: vm)
        let _ = vc.view
        vc.costTextField.text = "1.0.0"
        vc.didUpdateTextField(vc.costTextField)
        XCTAssert(vm.price == 0)
    }
    
    func testHandlingBadDataForCostField3() {
        let vm = CalculatorViewModel(productLabel: "Apple", price: 10, quantity: 1)
        let vc = CalculatorViewController(viewModel: vm)
        let _ = vc.view
        vc.costTextField.text = "."
        vc.didUpdateTextField(vc.costTextField)
        XCTAssert(vm.price == 0)
    }
    
    func testHandlingGoodDataForCostField() {
        let vm = CalculatorViewModel(productLabel: "Apple", price: 10, quantity: 1)
        let vc = CalculatorViewController(viewModel: vm)
        let _ = vc.view
        vc.costTextField.text = "20"
        vc.didUpdateTextField(vc.costTextField)
        XCTAssert(vm.price == 20)
    }
    
    func testHandlingGoodDataForCostField2() {
        let vm = CalculatorViewModel(productLabel: "Apple", price: 10, quantity: 1)
        let vc = CalculatorViewController(viewModel: vm)
        let _ = vc.view
        vc.costTextField.text = "20.00"
        vc.didUpdateTextField(vc.costTextField)
        XCTAssert(vm.price == 20)
    }
    
    func testHandlingGoodDataForCostField3() {
        let vm = CalculatorViewModel(productLabel: "Apple", price: 10, quantity: 1)
        let vc = CalculatorViewController(viewModel: vm)
        let _ = vc.view
        vc.costTextField.text = "2.00"
        vc.didUpdateTextField(vc.costTextField)
        XCTAssert(vm.price == 2)
    }
    
    func testHandlingBadDataForQuantityField() {
        let vm = CalculatorViewModel(productLabel: "Apple", price: 10, quantity: 1)
        let vc = CalculatorViewController(viewModel: vm)
        let _ = vc.view
        vc.quantityTextField.text = "abc"
        vc.didUpdateTextField(vc.quantityTextField)
        XCTAssert(vm.quantity == 0)
    }
    
    func testHandlingGoodDataForQuantityField() {
        let vm = CalculatorViewModel(productLabel: "Apple", price: 10, quantity: 1)
        let vc = CalculatorViewController(viewModel: vm)
        let _ = vc.view
        vc.quantityTextField.text = "100"
        vc.didUpdateTextField(vc.quantityTextField)
        XCTAssert(vm.quantity == 100)
    }
    
}
