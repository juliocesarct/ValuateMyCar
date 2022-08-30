//
//  YearModel.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 23/08/22.
//

import Foundation

struct YearModel: Codable {
    let id: String
    let year: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Value"
        case year = "Label"
    }
}
