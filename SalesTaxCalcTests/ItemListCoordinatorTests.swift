//
//  ItemListCoordinatorTests.swift
//  SalesTaxCalcTests
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import XCTest
@testable import SalesTaxCalc

class ItemListCoordinatorTests: XCTestCase {

    func testShowingItemList() {
        // GIVEN a coordinator showing the Item List
        let window = UIWindow(frame: .zero)
        window.makeKeyAndVisible()
        let coordinator = ItemListCoordinator(window: window)
        // WHEN the coordinator is started
        coordinator.start()
        // THEN the window should display an item list
        XCTAssert(window.rootViewController is UINavigationController)
        XCTAssert((window.rootViewController as! UINavigationController).viewControllers[0] is ItemListViewController)
    }

}
