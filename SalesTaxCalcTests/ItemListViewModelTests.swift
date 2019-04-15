//
//  ItemListViewModelTests.swift
//  SalesTaxCalcTests
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import XCTest
@testable import SalesTaxCalc

class ItemListViewModelTests: XCTestCase {

    func testAddingASingleItem() {
        // GIVEN CA selected state
        let viewModel = ItemListViewModel(selectedState: "CA")
        // WHEN adding a single item of price 100
        viewModel.addTicket(ticket: Ticket(label: "Apple", price: 100, quantity: 1))
        // THEN the calculated price should be with no discount and 8.25% tax
        XCTAssert(viewModel.list.count == 1)
        XCTAssert(viewModel.totalBill.contains("Total without taxes: 100"))
        XCTAssert(viewModel.totalBill.contains("Discount: 0%"))
        XCTAssert(viewModel.totalBill.contains("Tax: 8.25% +8.25"))
        XCTAssert(viewModel.totalBill.contains("Total: 108.25"))
    }
    
    func testAddingATwoItems() {
        // GIVEN AL selected state
        let viewModel = ItemListViewModel(selectedState: "AL")
        // WHEN adding two items of price 100, 300
        viewModel.addTicket(ticket: Ticket(label: "Apple", price: 100, quantity: 1))
        viewModel.addTicket(ticket: Ticket(label: "Pear", price: 300, quantity: 1))
        // THEN the calculated price should be with no discount and 4.00% tax
        XCTAssert(viewModel.list.count == 2)
        XCTAssert(viewModel.totalBill.contains("Total without taxes: 400"))
        XCTAssert(viewModel.totalBill.contains("Discount: 0%"))
        XCTAssert(viewModel.totalBill.contains("Tax: 4.00% +16.00"))
        XCTAssert(viewModel.totalBill.contains("Total: 416.00"))
    }
    
    func testChangingStateTax() {
        // GIVEN AL selected state
        let viewModel = ItemListViewModel(selectedState: "AL")
        // WHEN adding two items of price 100, 300
        viewModel.addTicket(ticket: Ticket(label: "Apple", price: 100, quantity: 1))
        viewModel.addTicket(ticket: Ticket(label: "Pear", price: 300, quantity: 1))
        // THEN the calculated price should be with no discount and 4.00% tax
        XCTAssert(viewModel.list.count == 2)
        XCTAssert(viewModel.totalBill.contains("Total without taxes: 400"))
        XCTAssert(viewModel.totalBill.contains("Discount: 0%"))
        XCTAssert(viewModel.totalBill.contains("Tax: 4.00% +16.00"))
        XCTAssert(viewModel.totalBill.contains("Total: 416.00"))
        // AND changing the state to CA
        viewModel.selectedState = "CA"
        // THEN the calculated price should be with no discount and 8.25% tax
        XCTAssert(viewModel.list.count == 2)
        XCTAssert(viewModel.totalBill.contains("Total without taxes: 400"))
        XCTAssert(viewModel.totalBill.contains("Discount: 0%"))
        XCTAssert(viewModel.totalBill.contains("Tax: 8.25% +33.00"))
        XCTAssert(viewModel.totalBill.contains("Total: 433.00"))
    }
    
    func testAddingATwoItemsWithDiscount() {
        // GIVEN CA selected state
        let viewModel = ItemListViewModel(selectedState: "CA")
        // WHEN adding two items of price 1000, 3000
        viewModel.addTicket(ticket: Ticket(label: "Apple", price: 1000, quantity: 2))
        viewModel.addTicket(ticket: Ticket(label: "Pear", price: 3000, quantity: 2))
        // THEN the calculated price should be with 7% discount and 8.25% tax
        XCTAssert(viewModel.list.count == 2)
        XCTAssert(viewModel.totalBill.contains("Total without taxes: 8000.00"))
        XCTAssert(viewModel.totalBill.contains("Discount: 7% -560.00"))
        XCTAssert(viewModel.totalBill.contains("Tax: 8.25% +613.80"))
        XCTAssert(viewModel.totalBill.contains("Total: 8053.80"))
    }
    
}
