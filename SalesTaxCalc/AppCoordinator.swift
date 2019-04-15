//
//  AppCoordinator.swift
//  SalesTaxCalc
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import UIKit

protocol Coordinator : class {
    var parent: Coordinator? { get set } // Parent should be defined weak
    var child: Coordinator? { get set }
    func start()
    var goBack: ((Any?) -> ())? { get set }
}

class AppCoordinator : Coordinator {

    private(set) var window: UIWindow
    
    weak var parent: Coordinator?
    var child: Coordinator?
    
    var goBack: ((Any?) -> ())?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let coordinator = ItemListCoordinator(window: window)
        coordinator.parent = self
        coordinator.start()
    }
    
}
