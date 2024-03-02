//
//  ActivityService.swift
//  Embrace ESG
//
//  Created by Erica Okamura on 01/03/24.
//

import Foundation

class ActivityService {
    
    func saveActivity(_ activity: Activity) async throws {
        guard let url = URL(string: "http://localhost:8080/atividades") else {
            return
        }
        
        let object = try JSONEncoder().encode(activity)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = object
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, _) =  try await URLSession.shared.data(for: request)
        
    }
    
    func retornaAtividades(_ usuarioId: Int64) async throws -> [Activity] {
        
        let usuario = try JSONEncoder().encode(usuarioId)

        guard let url = URL(string: "http://localhost:8080/atividades/usuarios/\(usuario)") else {
            return []
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) =  try await URLSession.shared.data(for: request)
        
        let returnObject = try JSONSerialization.jsonObject(with: data) as? [Activity]
        
        return returnObject!
    }
}
