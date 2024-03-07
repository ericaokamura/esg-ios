//
//  ContentView.swift
//  Embrace ESG
//
//  Created by Erica Okamura on 27/02/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var titulo: String = ""
    @State private var descricao: String = ""
    @State private var selection = 0
    private var service = ActivityService()
    @State var navigationFlag = false
    @State private var atividades : [Activity] = []
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack(spacing: 0) {
                    
                    Text("Embrace ESG")
                        .foregroundColor(Color.indigo)
                        .fontWeight(.bold)
                        .font(.system(size: 40))
                        .frame(width: 400, height: 300)
                        .padding(40)
                    
                    
                    Text("Título")
                        .foregroundColor(Color.indigo)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 400, height: 300)
                        .padding(-150)
                    
                    TextField("Dê um título para a sua atividade", text: $titulo)
                        .frame(width: 350, height: 300)
                        .font(.system(size: 16))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(-100)
                    
                    
                    Text("Descrição")
                        .foregroundColor(Color.indigo)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .frame(width: 400, height: 300)
                        .padding(-100)
                    
                    
                    TextField("Descreva em poucas palavras a sua atividade", text: $descricao)
                        .frame(width: 350, height: 300)
                        .font(.system(size: 16))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(-150)
                    
                    Picker(selection: $selection,
                           label: Text("Categorias")) {
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
                   .padding(60)
                    
                    
                    Button(action: {
                        
                        self.navigationFlag = true
                    
                        Task{
                            do {
                                try await salvarAtividade(Activity(titulo, descricao, "VOLUNTARIADO"))
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                        
                    }, label: {
                        Text("Salvar")
                    })
                    .foregroundColor(Color.indigo)
                    .fontWeight(.bold)
                    .padding(50)
                    
                    
                    NavigationLink(destination: ActivitiesListView(),
                                                   isActive: self.$navigationFlag,
                                                   label: {
                                                        
                                                   })
                    
                }
                
            }
            .frame(width: 1000, height: 1000)
            
        }
    }
    
    func salvarAtividade(_ activity: Activity) async throws {
        try await service.saveActivity(activity)
    }


}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
    

