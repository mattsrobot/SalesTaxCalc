//
//  SalesTaxCalcUITests.swift
//  SalesTaxCalcUITests
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import XCTest

class SalesTaxCalcUITests: XCTestCase {

    func testAddingAnItem() {
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["SalesTaxCalc.ItemListView"].buttons["Add"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["Product Label"].tap()
        elementsQuery.textFields["Product Label"].typeText("Apple")
        app.keyboards.buttons["Done"].tap()
        
        elementsQuery.textFields["Cost"].tap()
        elementsQuery.textFields["Cost"].typeText("300")
        elementsQuery.textFields["Quantity"].tap()
        elementsQuery.textFields["Quantity"].typeText("1")
        
        app.navigationBars["SalesTaxCalc.CalculatorView"].buttons["Done"].tap()
    }

}
