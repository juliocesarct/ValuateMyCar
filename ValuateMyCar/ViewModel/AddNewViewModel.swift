//
//  AddNewViewModel.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 19/08/22.
//

import Foundation
import Combine

protocol AddNewViewModelProtocol {
    func getBrands()
    func getModelsByBrand(brand: String)
    func getYearsByModel()
}

class AddNewViewModel: AddNewViewModelProtocol {
    
    let repository = Repository()
    @Published var models: [Model] = []
    @Published var brands: [Brand] = []
    
    var brandsNames: [String] {
        get{
            return self.brands.map{ $0.name }
        }
    }
    
    var references: [Reference] = [] {
        didSet {
            if references.count > 0{
                repository.getBrands(reference: references[0]) { brands, error in
                    guard let brands = brands else {
                        return
                    }
                    self.brands = brands
                }
            }
        }
    }
    

    
    func getModelsByBrand(brand: String) {
        
    }
    
    func getYearsByModel() {
        
    }
    
    func getBrands(){
         
        
    }
    
    init(){
        repository.getReferences { references, error in
            self.references = references ?? []
        }
    }
    
}
