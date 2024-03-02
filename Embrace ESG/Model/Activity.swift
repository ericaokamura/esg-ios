//
//  Activity.swift
//  Embrace ESG
//
//  Created by Erica Okamura on 01/03/24.
//

import Foundation

struct Activity: Codable, Identifiable {
    
    var id: Int64
        
    var titulo: String
    
    var descricao: String

    var categoria: String

    var criadoEm: String

    var usuarioId: Int32
    
    init(_ titulo: String, _ descricao: String, _ categoria: String) {
        self.id = -1
        self.titulo = titulo
        self.descricao = descricao
        self.categoria = categoria
        //let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd"
        self.criadoEm = "2024-03-01T20:09:09.000"
        self.usuarioId = 1
    }
}
