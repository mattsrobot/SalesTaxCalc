//
//  ItemTableViewCellTests.swift
//  SalesTaxCalcTests
//
//  Created by Matthew Wilkinson on 18/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import XCTest
@testable import SalesTaxCalc

class ItemTableViewCellTests: XCTestCase {
    
    func testOutletsConnected() {
        let cell = Bundle.main.loadNibNamed("ItemTableViewCell", owner: nil, options: nil)?.first as! ItemTableViewCell
        XCTAssert(cell.label != nil)
    }
    
    func testDisplaysTheViewModel() {
        let cell = Bundle.main.loadNibNamed("ItemTableViewCell", owner: nil, options: nil)?.first as! ItemTableViewCell
        let vm = ItemViewModel(title: "Hello world")
        cell.display(vm)
        XCTAssert(cell.label.text == "Hello world")
    }
    
}
