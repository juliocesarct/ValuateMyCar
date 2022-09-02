//
//  RepositoryError.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 01/09/22.
//

import Foundation

enum NetworkError: Error {
    case apiError
    case invalidEnpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError:
            return "Failed to fetch data"
        case .invalidEnpoint:
            return "Invalid endpoint"
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return "No data"
        case .serializationError:
            return "Failed to decode data"
        }
    }
}

