//
//  Coordinator.swift
//  Reddit_top_charts
//
//  Created by Nikolay Dementiev on 16.06.2020.
//  Copyright © 2020 test reddit. All rights reserved.
//

protocol Coordinator: class {
    func start()
}

protocol WebCoordinator: class {
    func start(withUrlString: String?)
}
