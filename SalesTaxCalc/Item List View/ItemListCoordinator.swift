//
//  ItemListCoordinator.swift
//  SalesTaxCalc
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import UIKit

class ItemListCoordinator : Coordinator {

    private(set) var window: UIWindow
    
    weak var parent: Coordinator?
    var child: Coordinator?
    
    var goBack: ((Any?) -> ())?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let vm = ItemListViewModel(selectedState: "CA")
        let vc = ItemListViewController(viewModel: vm)
        vm.didRequestNewProduct = { [weak vc, weak vm] in
            if let vc = vc {
                let coordinator = CalculatorCoordinator(controller: vc)
                coordinator.goBack = { options in
                    self.child = nil
                    if let ticket = options as? Ticket {
                        vm?.addTicket(ticket: ticket)
                    }
                }
                coordinator.parent = self
                self.child = coordinator
                coordinator.start()
            }
        }
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
    }

}
