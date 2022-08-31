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
    private let repository = Repository()
    
    init(){
        self.getReferences()
    }
    
    func getValuation(car: Car, reference: Reference) {
        
        guard let brandId = car.brandId else {return}
        guard let modelId = car.modelId else {return}
        guard let yearModelId = car.yearModelId else {return}
        
        repository.getValuation(brandId: brandId, referenceId: String(reference.id), modelId: modelId, yearModelId: yearModelId ,completion: { valuation, error in
            self.valuation = valuation ?? nil
        })
        
    }
    
    func deleteCar(car: Car){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(car)
        do {
            try context.save()
        }catch{
            
        }
        
    }
    
    func getReferences(){
        repository.getReferences { references, error in
            self.references = references ?? []
        }
    }
    
}
