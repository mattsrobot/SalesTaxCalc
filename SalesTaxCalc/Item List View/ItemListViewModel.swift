//
//  ItemListViewModel.swift
//  SalesTaxCalc
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import UIKit

struct ItemViewModel {
    let title: String
}

class ItemListViewModel {

    var didRequestNewProduct: (() -> ())?
    var reloadBlock: (() -> ())?

    private(set) var stateCodes = ["UT", "NV", "TX", "AL", "CA"]
    private var map = ["UT" : ("Utah", 0.0685), "NV" : ("Nevada", 0.08), "TX" : ("Texas", 0.0625), "AL" : ("Alabama", 0.04), "CA" : ("California", 0.0825)]
    private(set) var list = [ItemViewModel]()
    private var tickets = [Ticket]()
    private(set) var totalBill = ""
    
    var selectedState: String {
        didSet {
            updateList()
        }
    }
    
    init(selectedState: String) {
        self.selectedState = selectedState
    }
    
    func stateNameFor(code: String) -> String? {
        return map[code]?.0
    }
    
    func stateTaxFor(code: String) -> Double? {
        return map[code]?.1
    }
    
    private func updateList() {
        
        if tickets.count > 0 {
            let totalWithoutTaxes = tickets.reduce(into: 0.0, { $0 = $0 + ($1.price * Double($1.quantity))})
            let totalWithoutTaxesString = String(format: "Total without taxes: %.02f", totalWithoutTaxes)
            var discountRate = 0.0
            if totalWithoutTaxes > 50000 {
                discountRate = 0.15
            } else if totalWithoutTaxes > 10000 {
                discountRate = 0.10
            } else if totalWithoutTaxes > 7000 {
                discountRate = 0.07
            } else if totalWithoutTaxes > 5000 {
                discountRate = 0.05
            } else if totalWithoutTaxes > 1000 {
                discountRate = 0.03
            }
            let discount = totalWithoutTaxes * discountRate
            let discountRateString = String(format: "%.0f", discountRate * 100)
            let discuntTotalString = String(format: "%.02f", discount)
            let discountString = "Discount: \(discountRateString)% -\(discuntTotalString)"
            let taxRate = stateTaxFor(code: selectedState) ?? 0.0
            let taxRateString = String(format: "%.02f", taxRate * 100)
            let taxAmount = (totalWithoutTaxes - discount) * taxRate
            let taxAmountString =  String(format: "%.02f", taxAmount)
            let taxString = "Tax: \(taxRateString)% +\(taxAmountString)"
            let total = totalWithoutTaxes - discount + taxAmount
            let totalString = String(format: "Total: %.02f", total)
            totalBill = "----------\n\(totalWithoutTaxesString)\n\(discountString)\n\(taxString)\n----------\n\(totalString)"
        } else {
            totalBill = ""
        }
        
        list = tickets.map({
            ItemViewModel(title: "\($0.label), \($0.quantity), \(String(format: "%.02f", $0.price)), \(String(format: "%.02f", Double($0.quantity) * $0.price))")
        })
        
        reloadBlock?()
    }
    
    func addTicket(ticket: Ticket) {
        tickets.append(ticket)
        updateList()
    }
    
}
