//
//  AddNewViewModel.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 19/08/22.
//

import Foundation
import Combine
import UIKit

protocol AddNewViewModelProtocol {
    func getReferences()
    func getBrands()
    func getModelsByBrand(brand: Brand)
    func getYearsByModel(brand: Brand, model: Model)
    func saveCar(brand: Brand, model: Model, year: YearModel, nickname: String, image: UIImage?)
}

class AddNewViewModel: AddNewViewModelProtocol {
    
    private let repository = Repository()
    private let localRepository = LocalRepository()
    
    @Published private(set) var models: [Model] = []
    @Published private(set) var brands: [Brand] = []
    @Published private(set) var yearModel: [YearModel] = []
    @Published private(set) var errorString = ""
    private(set) var car: Car! = nil
    private(set) var references: [Reference] = [] {
        didSet {
            if references.count > 0{
                getBrands()
            }
        }
    }
    
    var brandsNames: [String] {
        get{
            return self.brands.map{ $0.name.capitalized }
        }
    }
    
    var modelsNames: [String] {
        get{
            return self.models.map{ $0.name.capitalized }
        }
    }
    
    var yearLabels: [String] {
        get{
            return self.yearModel.map{ $0.year }
        }
    }
    
    func getYearsByModel(brand: Brand, model: Model) {
        repository.getYearModel(brandId: brand.id, referenceId: String(references[0].id), modelId: String(model.id), completion: { yearModels, error in
            
            if error != nil{
                self.errorString = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            self.yearModel = yearModels ?? []
            
        })
    }
    
    func getModelsByBrand(brand: Brand) {
        repository.getModels(brandId: brand.id, referenceId: String(references[0].id) ,completion: { models, error in
            
            if error != nil{
                self.errorString = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            self.models = models ?? []
        })
    }
    
    func getBrands(){
        repository.getBrands(referenceId: String(references[0].id) ) { brands, error in
            
            if error != nil{
                self.errorString = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            self.brands = brands ?? []
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
    
    func saveCar(brand: Brand, model: Model, year: YearModel, nickname: String, image: UIImage?){
        
        localRepository.saveCar(brand: brand, model: model, year: year, nickname: nickname, image: image) { error in
            if error != nil {
                self.errorString = error?.localizedDescription ?? "Unknown error"
            }
        }
    }
    
    init(){
        getReferences()
    }
    
}
