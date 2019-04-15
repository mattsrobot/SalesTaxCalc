//
//  CalculatorViewCoordinatorTests.swift
//  SalesTaxCalcTests
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import XCTest
@testable import SalesTaxCalc

class MockViewController : UIViewController {
    var mockPresentVC: UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        mockPresentVC = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

class CalculatorViewCoordinatorTests: XCTestCase {

    func testHidingTheCalculator() {
        // GIVEN a coordinator showing the Item List
        let vc = MockViewController()
        let coordinator = CalculatorCoordinator(controller: vc)
        var didCallGoBack = false
        coordinator.goBack = { _ in
            didCallGoBack = true
        }
        coordinator.start()
        XCTAssert(vc.mockPresentVC is UINavigationController)
        XCTAssert((vc.mockPresentVC as! UINavigationController).viewControllers[0] is CalculatorViewController)

        // WHEN the user taps cancel
        let calculatorVC = (vc.mockPresentVC as! UINavigationController).viewControllers[0] as! CalculatorViewController
        calculatorVC.didTapCancel()
        // THEN the coordinator should go back
        XCTAssert(didCallGoBack)
    }
    
    func testAddingANewItem() {
        // GIVEN a coordinator showing the Item List
        let vc = MockViewController()
        let coordinator = CalculatorCoordinator(controller: vc)
        var ticket: Ticket?
        coordinator.goBack = { options in
            ticket = options as? Ticket
        }
        coordinator.start()
        XCTAssert(vc.mockPresentVC is UINavigationController)
        XCTAssert((vc.mockPresentVC as! UINavigationController).viewControllers[0] is CalculatorViewController)
        // AND calculator has an item with 300 price, 1 quantity, title Apple
        let calculatorVC = (vc.mockPresentVC as! UINavigationController).viewControllers[0] as! CalculatorViewController
        let _ = calculatorVC.view
        calculatorVC.productLabelTextField.text = "Apple"
        calculatorVC.didUpdateTextField(calculatorVC.productLabelTextField)
        calculatorVC.costTextField.text = "300.00"
        calculatorVC.didUpdateTextField(calculatorVC.costTextField)
        calculatorVC.quantityTextField.text = "1"
        calculatorVC.didUpdateTextField(calculatorVC.quantityTextField)
        // WHEN the user taps done
        calculatorVC.didTapDone()
        // THEN the coordinator should go back, with the ticket
        XCTAssert(ticket?.price == 300.00)
        XCTAssert(ticket?.quantity == 1)
        XCTAssert(ticket?.label == "Apple")
    }

}
