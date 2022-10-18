//
//  LocalRepository.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 02/09/22.
//

import Foundation
import UIKit

protocol LocalRepositoryProtocol {
    func fetchCars(completion: @escaping ([Car]?, LocalDataError?) -> Void )
    func deleteCar(car: Car, completion: @escaping (LocalDataError?) -> Void )
    func saveCar(brand: Brand, model: Model, year: YearModel, nickname: String, image: UIImage?, completion: @escaping (LocalDataError?) -> Void )
}

class LocalRepository: LocalRepositoryProtocol {
    
    private let context = CoreDataService.shared.mainContext
    
    func fetchCars( completion: @escaping ([Car]?, LocalDataError?) -> Void ){
        
        do {
            let cars = try context.fetch(Car.fetchRequest())
            completion(cars,nil)
        }catch{
            let error: LocalDataError = .fetchError
            completion(nil, error)
        }
        
    }
    
    func deleteCar(car: Car, completion: @escaping (LocalDataError?) -> Void ){
        
        context.delete(car)
        
        do {
            try context.save()
            completion(nil)
        }catch{
            completion(.deleteError)
        }

    }
    
    func saveCar(brand: Brand, model: Model, year: YearModel, nickname: String, image: UIImage?, completion: @escaping (LocalDataError?) -> Void ){
        
        let carToSave = Car(context: context)
        carToSave.brandId = String(brand.id)
        carToSave.modelId = String(model.id)
        carToSave.yearModelId = String(year.id)
        carToSave.nickname = nickname
        if let image = image {
            carToSave.carImage = image
        }
        
        do{
            try context.save()
            completion(nil)
        }catch{
            completion(.saveError)
        }
        
    }
    
    func saveContext(){
        CoreDataService.shared.saveContext()
    }

}
