//
//  Activity.swift
//  Embrace ESG
//
//  Created by Erica Okamura on 01/03/24.
//

import Foundation

struct Activity: Codable, Identifiable {
    
    var titulo: String
    
    var descricao: String

    var categoria: String

    var criadoEm: String

    var usuarioId: Int32
    
    var id: Int
    
    init(_ titulo: String, _ descricao: String, _ categoria: String) {
        self.id = -1
        self.titulo = titulo
        self.descricao = descricao
        self.categoria = categoria
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sss"
        self.criadoEm = formatter.string(from: Date())
        self.usuarioId = 1
    }
}
