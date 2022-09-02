//
//  LocalDataError.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 02/09/22.
//

import Foundation

enum LocalDataError: Error {
    case fetchError
    case saveError
    case deleteError
    case alreadyExists
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .fetchError:
            return "Failed to fetch data from database"
        case .saveError:
            return "Failed to save data"
        case .deleteError:
            return "Failed to delete data"
        case .alreadyExists:
            return "Data already exists"
        case .invalidData:
            return "Invalid Data"
        }

    }
}
