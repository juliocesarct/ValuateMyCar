//
//  Reference.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 22/08/22.
//

import Foundation

struct Reference: Codable {
    let id: Int
    let month: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Codigo"
        case month = "Mes"
    }
}
