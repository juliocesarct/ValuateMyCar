//
//  Coordinator.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 21/10/22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
