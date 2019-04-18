//
//  ItemListViewControllerTests.swift
//  SalesTaxCalcTests
//
//  Created by Matthew Wilkinson on 18/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import XCTest
@testable import SalesTaxCalc

class ItemListViewControllerTests: XCTestCase {

    func testOutletsConnected() {
        let vm = ItemListViewModel(selectedState: "CA", stateCodes: ["CA", "AL"])
        let vc = ItemListViewController(viewModel: vm)
        let _ = vc.view
        XCTAssert(vc.statePicker != nil)
        XCTAssert(vc.tableView != nil)
    }
    
    func testPickerViewShowingCorrectNumberOfItems() {
        // GIVEN a view model that has only two states
        let vm = ItemListViewModel(selectedState: "CA", stateCodes: ["CA", "AL"])
        let vc = ItemListViewController(viewModel: vm)
        // WHEN the picker view is loaded
        let _ = vc.view
        // THEN the picker view should display two states
        XCTAssert(vc.statePicker.numberOfRows(inComponent: 0) == 2)
    }
    
    func testPickerViewHandlingBadData() {
        // GIVEN a view model that has no states
        let vm = ItemListViewModel(selectedState: "CA", stateCodes: [])
        let vc = ItemListViewController(viewModel: vm)
        // WHEN the picker view is loaded
        let _ = vc.view
        // THEN the picker view should display nothing
        XCTAssert(vc.statePicker.numberOfRows(inComponent: 0) == 0)
    }
    
    func testShowsCorrectNumberOfTableRowsForNoItems() {
        // GIVEN a view model that has no ticket items added
        let vm = ItemListViewModel(selectedState: "CA", stateCodes: ["CA"], tickets: [])
        let vc = ItemListViewController(viewModel: vm)
        // WHEN the view is loaded
        let _ = vc.view
        // THEN the table view should display a zero rows for the item
        XCTAssert(vc.tableView.numberOfRows(inSection: 0) == 0)
        // AND the table view should display a zero rows for the total price
        XCTAssert(vc.tableView.numberOfRows(inSection: 1) == 0)
    }
    
    func testShowsCorrectNumberOfTableRowsForSingleItem() {
        // GIVEN a view model that has one ticket item added
        let vm = ItemListViewModel(selectedState: "CA", stateCodes: ["CA"], tickets: [Ticket(label: "Apple", price: 10, quantity: 1)])
        let vc = ItemListViewController(viewModel: vm)
        // WHEN the view is loaded
        let _ = vc.view
        // THEN the table view should display a single row for the item
        XCTAssert(vc.tableView.numberOfRows(inSection: 0) == 1)
        // AND the table view should display a single row for the total price
        XCTAssert(vc.tableView.numberOfRows(inSection: 1) == 1)
    }
    
    func testShowsCorrectNumberOfTableRowsForTwoItems() {
        // GIVEN a view model that has two ticket items added
        let vm = ItemListViewModel(selectedState: "CA", stateCodes: ["CA"], tickets: [Ticket(label: "Apple", price: 10, quantity: 1), Ticket(label: "Pear", price: 20, quantity: 1)])
        let vc = ItemListViewController(viewModel: vm)
        // WHEN the view is loaded
        let _ = vc.view
        // THEN the table view should display a two rows for the items
        XCTAssert(vc.tableView.numberOfRows(inSection: 0) == 2)
        // AND the table view should display a single row for the total price
        XCTAssert(vc.tableView.numberOfRows(inSection: 1) == 1)
    }
    
    func testShowsCorrectNumberOfTableRowsWhenAddingAFurtherItem() {
        // GIVEN a view model that has two ticket items added
        let vm = ItemListViewModel(selectedState: "CA", stateCodes: ["CA"], tickets: [Ticket(label: "Apple", price: 10, quantity: 1), Ticket(label: "Pear", price: 20, quantity: 1)])
        let vc = ItemListViewController(viewModel: vm)
        // WHEN the view is loaded and user adds a ticket
        let _ = vc.view
        vm.addTicket(ticket: Ticket(label: "Grape", price: 2, quantity: 4))
        // THEN the table view should display a three rows for the items
        XCTAssert(vc.tableView.numberOfRows(inSection: 0) == 3)
        // AND the table view should display a single row for the total price
        XCTAssert(vc.tableView.numberOfRows(inSection: 1) == 1)
    }
    
    
}
