//
//  Model.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 23/08/22.
//

import Foundation

struct Models: Codable {
    
    let models: [Model]
    
    enum CodingKeys: String, CodingKey {
        case models = "Modelos"
    }
    
}

struct Model: Codable {
    
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Value"
        case name = "Label"
    }
}
