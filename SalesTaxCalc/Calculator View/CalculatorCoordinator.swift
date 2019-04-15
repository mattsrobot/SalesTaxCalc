//
//  CalculatorCoordinator.swift
//  SalesTaxCalc
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import UIKit

class CalculatorCoordinator : Coordinator {
    
    private(set) var controller: UIViewController
    
    weak var parent: Coordinator?
    var child: Coordinator?
    
    var goBack: ((Any?) -> ())?

    init(controller: UIViewController) {
        self.controller = controller
    }
    
    private func didTapCancel() {
        goBack?(nil)
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func didTapDone(_ options: Any?) {
        goBack?(options)
        controller.dismiss(animated: true, completion: nil)
    }
    
    func start() {
        let vm = CalculatorViewModel(productLabel: nil, price: 0, quantity: 0)
        vm.didTapCancel = {
            self.didTapCancel()
        }
        vm.didTapDone = { [weak vm] in
            self.didTapDone(vm?.ticket)
        }
        let vc = CalculatorViewController(viewModel: vm)
        let navigationController = UINavigationController(rootViewController: vc)
        controller.present(navigationController, animated: true, completion: nil)
    }
    
    deinit {
        print("deinit CalculatorCoordinator")
    }
}
