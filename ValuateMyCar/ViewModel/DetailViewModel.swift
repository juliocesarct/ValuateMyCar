//
//  DetailViewModel.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 30/08/22.
//

import Foundation
import UIKit
import Combine

class DetailViewModel {
    
    @Published private(set) var valuation: Valuation? = nil
    @Published private(set) var references: [Reference] = []
    @Published private(set) var errorString = ""
    
    private let repository: RepositoryProtocol
    private let localRepository: LocalRepositoryProtocol
    
    init(repository: RepositoryProtocol = Repository(), localRepository: LocalRepositoryProtocol = LocalRepository() ){
        self.repository = repository
        self.localRepository = localRepository
        self.getReferences()
    }
    
    func getValuation(car: Car, reference: Reference) {
        
        guard let brandId = car.brandId else {return}
        guard let modelId = car.modelId else {return}
        guard let yearModelId = car.yearModelId else {return}
        
        repository.getValuation(brandId: brandId, referenceId: String(reference.id), modelId: modelId, yearModelId: yearModelId ,completion: { valuation, error in
            
            if error != nil{
                self.errorString = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            guard let valuation = valuation else {
                self.errorString = "Failed to unwrap valuation"
                return
            }

            self.valuation = valuation
        })
        
    }
    
    func deleteCar(car: Car){
        
        localRepository.deleteCar(car: car) { error in
            if error != nil {
                self.errorString = error?.localizedDescription ?? "Unknown error"
            }
        }
        
    }
    
    func getReferences(){
        repository.getReferences { references, error in
            
            if error != nil{
                self.errorString = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            self.references = references ?? []
        }
    }
    
}
