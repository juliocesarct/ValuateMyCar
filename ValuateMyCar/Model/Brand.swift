//
//  Brand.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 23/08/22.
//

import Foundation

struct Brand: Codable {
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Value"
        case name = "Label"
    }
}
