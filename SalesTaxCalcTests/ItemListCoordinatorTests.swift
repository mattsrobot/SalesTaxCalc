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

    func testShowingTheCalculator() {
        // GIVEN a coordinator showing the Item List
        let window = UIWindow(frame: .zero)
        window.makeKeyAndVisible()
        let coordinator = ItemListCoordinator(window: window)
        coordinator.start()
        XCTAssert(window.rootViewController is UINavigationController)
        XCTAssert((window.rootViewController as! UINavigationController).viewControllers[0] is ItemListViewController)
        // WHEN the user taps to add a new item
        let vc = (window.rootViewController as! UINavigationController).viewControllers[0] as! ItemListViewController
        vc.didRequestNewProduct()
        // THEN the coordinator should present the calculator view
        XCTAssert(coordinator.child is CalculatorCoordinator)
    }

}
