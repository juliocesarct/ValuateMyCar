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
    func getBrands()
    func getModelsByBrand(brand: Brand)
    func getYearsByModel(brand: Brand, model: Model)
}

class AddNewViewModel: AddNewViewModelProtocol {
    
    private let repository = Repository()
    @Published var models: [Model] = []
    @Published var brands: [Brand] = []
    @Published var yearModel: [YearModel] = []
    @Published var valuation: Valuation? = nil
    private(set) var car: Car! = nil
    var references: [Reference] = [] {
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
    
    func saveCar(brand: Brand, model: Model, year: YearModel, nickname: String){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        car = Car(context: context)
        car.brandId = String(brand.id)
        car.modelId = String(model.id)
        car.yearModelId = String(year.id)
        car.nickname = nickname
        
        do{
            try context.save()
        }catch{
            print("erro inesperado ao salvar")
        }
        
    }
    
    func getValuation() {
        
        guard let brandId = car.brandId else {return}
        guard let modelId = car.modelId else {return}
        guard let yearModelId = car.yearModelId else {return}
        
        repository.getValuation(brandId: brandId, referenceId: String(references[0].id), modelId: modelId, yearModelId: yearModelId ,completion: { valuation, error in
            self.valuation = valuation ?? nil
        })
        
    }
    
    func getYearsByModel(brand: Brand, model: Model) {
        repository.getYearModel(brandId: brand.id, referenceId: String(references[0].id), modelId: String(model.id), completion: { yearModels, error in
            self.yearModel = yearModels ?? []
        })
    }
    
    func getModelsByBrand(brand: Brand) {
        repository.getModels(brandId: brand.id, referenceId: String(references[0].id) ,completion: { models, error in
            self.models = models ?? []
        })
    }

    
    func getBrands(){
        repository.getBrands(referenceId: String(references[0].id) ) { brands, error in
            guard let brands = brands else {
                return
            }
            self.brands = brands
        }
    }
    
    func getReferences(){
        repository.getReferences { references, error in
            self.references = references ?? []
        }
    }
    
    init(){
        getReferences()
    }
    
}
