//
//  Car+CoreDataProperties.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 30/08/22.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var brandId: String?
    @NSManaged public var carImage: NSObject?
    @NSManaged public var modelId: String?
    @NSManaged public var nickname: String?
    @NSManaged public var yearModelId: String?

}

extension Car : Identifiable {

}
