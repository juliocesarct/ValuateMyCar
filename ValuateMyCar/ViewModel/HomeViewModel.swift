//
//  HomeViewModel.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 30/08/22.
//

import Foundation

class HomeViewModel {
    
    @Published private(set) var cars: [Car] = []
    @Published private(set) var errorString = ""
    
    private let localRepository: LocalRepositoryProtocol
    
    init(localRepository: LocalRepositoryProtocol = LocalRepository() ){
        self.localRepository = localRepository
    }
    
    func fetchCars(){
        
        localRepository.fetchCars { cars, error in
            if error != nil {
                self.errorString = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            guard let cars = cars else {
                self.errorString = "Failed to load cars"
                return
            }
            
            self.cars = cars
        }
        
    }
    
}
