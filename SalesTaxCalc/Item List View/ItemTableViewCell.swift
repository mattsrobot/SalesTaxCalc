//
//  ItemTableViewCell.swift
//  SalesTaxCalc
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func display(_ viewModel: ItemViewModel) {
        label.text = viewModel.title
    }
    
}
