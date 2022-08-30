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
    
    func getBrands(referenceId: String ,completion: @escaping ([Brand]?, Error? ) -> Void ){
        
        let endpoint = "/ConsultarMarcas"
        let body = ["codigoTabelaReferencia":referenceId, "codigoTipoVeiculo":"1"]
        
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
    
    func getModels(brandId: String, referenceId: String ,completion: @escaping ([Model]?, Error? ) -> Void ){
        
        let endpoint = "/ConsultarModelos"
        let body = ["codigoTabelaReferencia":referenceId, "codigoTipoVeiculo":"1", "codigoMarca":brandId]
        
        post(endpoint: endpoint, body: body){ data, error in
            var models: [Model] = []
            //var refError = nil
            
            if error != nil {
                
            }
            
            guard let data = data else {
                return
            }
                
            do{
                models = try JSONDecoder().decode(Models.self, from: data).models
            }catch{
                
            }
            
            completion(models, nil )
            return
        }
    }
    
    func getYearModel(brandId: String, referenceId: String, modelId: String ,completion: @escaping ([YearModel]?, Error? ) -> Void ){
        
        let endpoint = "/ConsultarAnoModelo"
        let body = ["codigoTabelaReferencia":referenceId, "codigoTipoVeiculo":"1", "codigoMarca":brandId, "codigoModelo":modelId]
        
        post(endpoint: endpoint, body: body){ data, error in
            var references: [YearModel] = []
            
            if error != nil {
                
            }
            
            guard let data = data else {
                return
            }
                
            do{
                references = try JSONDecoder().decode([YearModel].self, from: data)
            }catch{
                
            }
            
            completion(references, nil )
            return
        }
    }
    
    func getValuation(brandId: String, referenceId: String, modelId: String ,yearModelId: String ,completion: @escaping (Valuation?, Error? ) -> Void){
        
        let endpoint = "/ConsultarValorComTodosParametros"
        let body = ["codigoTabelaReferencia":referenceId,
                    "codigoMarca":brandId,
                    "codigoModelo":modelId,
                    "codigoTipoVeiculo":"1",
                    "anoModelo": String(yearModelId.prefix(4)),
                    "codigoTipoCombustivel":"1",
                    "tipoVeiculo":"carro",
                    "tipoConsulta":"tradicional"]
        
        post(endpoint: endpoint, body: body){ data, error in
            var valuation: Valuation? = nil
            
            if error != nil {
                
            }
            
            guard let data = data else {
                return
            }
                
            do{
                valuation = try JSONDecoder().decode(Valuation.self, from: data)
            }catch{
                
            }
            
            completion(valuation, nil )
            return
        }
    }
    
    private func post(endpoint: String , body: [String:String]? = nil, completion: @escaping (Data?, Error? ) -> Void ){
        
        if let url = URL(string: baseURL+endpoint ) {
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            
            if let body = body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            }
            
            let postTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                
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
