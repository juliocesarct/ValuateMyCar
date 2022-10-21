//
//  MainCoordinator.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 21/10/22.
//

import UIKit

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showAddCar(){
        let vc = AddNewViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCarDetail(car: Car){
        let vc = DetailViewController()
        vc.car = car
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showError(title: String, description: String){
        let vc = ErrorViewController()
        vc.coordinator = self
        vc.titleLabel.text = title
        vc.descriptionLabel.text = description
        navigationController.present(vc, animated: false)
    }
    
}
