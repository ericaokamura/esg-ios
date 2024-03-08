//
//  ContentView.swift
//  Embrace ESG
//
//  Created by Erica Okamura on 27/02/24.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var titulo: String = ""
    @State private var descricao: String = ""
    @State private var selection = 0
    private var service = ActivityService()
    @State var navigationFlag = false
    @State private var atividades: [Activity] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Embrace ESG")
                    .foregroundColor(Color.indigo)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(40)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Título")
                        .foregroundColor(Color.indigo)
                        .font(.title)
                        .fontWeight(.bold)
                    TextField("Dê um título para a sua atividade", text: $titulo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.body)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Descrição")
                        .foregroundColor(Color.indigo)
                        .font(.title2)
                        .fontWeight(.bold)
                    TextField("Descreva em poucas palavras a sua atividade", text: $descricao)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.body)
                }
                
                Picker(selection: $selection, label: Text("Categorias")) {
                    Text("Escolha uma categoria").tag(0)
                        .foregroundColor(Color.indigo)
                    Text("VOLUNTARIADO").tag(1)
                        .foregroundColor(Color.indigo)
                    Text("COLETA_SELETIVA").tag(2)
                        .foregroundColor(Color.indigo)
                    Text("CULTIVO_HORTA_DOMESTICA").tag(3)
                        .foregroundColor(Color.indigo)
                    Text("PRATICA_ATIVIDADES_FISICAS").tag(4)
                        .foregroundColor(Color.indigo)
                    Text("HABITOS_ALIMENTARES_SAUDAVEIS").tag(5)
                        .foregroundColor(Color.indigo)
                }
                .accentColor(.indigo)
                .padding(20)
                
                Button(action: {
                    self.navigationFlag = true
                    Task {
                        do {
                            try await salvarAtividade(Activity(titulo, descricao, retornaCategoria(selection)))
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }, label: {
                    Text("Salvar")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(10)
                        .background(Color.indigo)
                        .cornerRadius(8)
                })
                
                NavigationLink(destination: ActivitiesListView(), isActive: self.$navigationFlag) {}
                
                Spacer()
            }
            .padding(20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Nova Atividade")
        }
    }
    
    func retornaCategoria(_ selection: Int) -> String {
        switch selection {
            case 1: return "VOLUNTARIADO"
            case 2: return "COLETA_SELETIVA"
            case 3: return "CULTIVO_HORTA_DOMESTICA"
            case 4: return "PRATICA_ATIVIDADES_FISICAS"
            case 5: return "HABITOS_ALIMENTARES_SAUDAVEIS"
            default: return "VOLUNTARIADO"
        }
    }
    
    func salvarAtividade(_ activity: Activity) async throws {
        try await service.saveActivity(activity)
    }
}
