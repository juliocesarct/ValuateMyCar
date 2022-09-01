//
//  Valuation.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 25/08/22.
//

import Foundation

struct Valuation: Codable {
    let month: String
    let valuation: String
    let yearModel: Int
    let model: String
    
    enum CodingKeys: String, CodingKey {
        case month = "MesReferencia"
        case valuation = "Valor"
        case yearModel = "AnoModelo"
        case model = "Modelo"
    }
}
