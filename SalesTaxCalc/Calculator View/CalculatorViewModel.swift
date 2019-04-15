//
//  CalculatorViewModel.swift
//  SalesTaxCalc
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import UIKit

class CalculatorViewModel {
    
    var canAddProduct: ((Bool) -> ())?
    var didTapCancel: (() -> ())?
    var didTapDone: (() -> ())?
    
    var rightButtonEnabled: Bool {
        return productLabel != nil && quantity > 0 && price > 0
    }
    
    var ticket: Ticket? {
        guard let productLabel = productLabel else {
            return nil
        }
        
        return Ticket(label: productLabel, price: price, quantity: quantity)
    }
    
    var productLabel: String? {
        didSet {
            tryToAddProduct()
        }
    }
    
    var price: Double = 0.0 {
        didSet {
            tryToAddProduct()
        }
    }
    
    var quantity: Int = 0 {
        didSet {
            tryToAddProduct()
        }
    }
    
    init(productLabel: String?, price: Double, quantity: Int) {
        self.productLabel = productLabel
        self.price = price
        self.quantity = quantity
    }

    private func tryToAddProduct() {
        canAddProduct?(rightButtonEnabled)
    }
    
    deinit {
        print("deinit CalculatorViewModel")
    }
}
