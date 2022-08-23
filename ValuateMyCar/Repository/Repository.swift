//
//  Repository.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 19/08/22.
//

import Foundation

class Repository {
    
    let baseURL = "https://veiculos.fipe.org.br/api/veiculos"
    
    func getReferences(completion: @escaping ([Reference]?, Error? ) -> Void ){
        
        let endpoint = "/ConsultarTabelaDeReferencia"
        
        post(endpoint: endpoint){ data, error in
            var references: [Reference] = []
            //var refError = nil
            
            if error != nil {
                
            }
            
            guard let data = data else {
                return
            }
                
            do{
                references = try Array(JSONDecoder().decode([Reference].self, from: data)[0..<12])
            }catch{
                
            }
            
            completion(references, nil )
            return
        }
    }
    
    func getBrands(reference: Reference ,completion: @escaping ([Brand]?, Error? ) -> Void ){
        
        let endpoint = "/ConsultarMarcas"
        let body = ["codigoTabelaReferencia":String(reference.id), "codigoTipoVeiculo":"1"]
        
        post(endpoint: endpoint, body: body){ data, error in
            var brands: [Brand] = []
            //var refError = nil
            
            if error != nil {
                
            }
            
            guard let data = data else {
                return
            }
                
            do{
                brands = try JSONDecoder().decode([Brand].self, from: data)
            }catch{
                
            }
            
            completion(brands, nil )
            return
        }
    }
    
    func getModels(completion: @escaping ([Reference]?, Error? ) -> Void ){
        
        let endpoint = "/ConsultarModelos"
        
        post(endpoint: endpoint){ data, error in
            var references: [Reference] = []
            //var refError = nil
            
            if error != nil {
                
            }
            
            guard let data = data else {
                return
            }
                
            do{
                references = try Array(JSONDecoder().decode([Reference].self, from: data)[0..<12])
            }catch{
                
            }
            
            completion(references, nil )
            return
        }
    }
    
    func getYearModel(completion: @escaping ([Reference]?, Error? ) -> Void ){
        
        let endpoint = "/ConsultarAnoModelo"
        
        post(endpoint: endpoint){ data, error in
            var references: [Reference] = []
            //var refError = nil
            
            if error != nil {
                
            }
            
            guard let data = data else {
                return
            }
                
            do{
                references = try Array(JSONDecoder().decode([Reference].self, from: data)[0..<12])
            }catch{
                
            }
            
            completion(references, nil )
            return
        }
    }
    
    private func post(endpoint: String , body: [String:String]? = nil, completion: @escaping (Data?, Error? ) -> Void ){
        
        if let url = URL(string: baseURL+endpoint ) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            if body != nil {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            }
            
            let postTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                
                print(response)
                
                if error != nil {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil,error)
                    return
                }
                
                completion(data,nil)
                
            })
            
            postTask.resume()
        }
        
        return
    }
    
}
