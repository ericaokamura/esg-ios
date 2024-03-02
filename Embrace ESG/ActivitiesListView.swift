//
//  ActivitiesListView.swift
//  Embrace ESG
//  Created by Erica Okamura on 01/03/24.
//

import SwiftUI

struct ActivitiesListView: View {
        
    @State var activities = [Activity("Horta", "Horta", "VOLUNTARIADO")]
    var service = ActivityService()
    
    var body: some View {
    
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    Text("Atividades Cadastradas")
                        .foregroundColor(Color.indigo)
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                
                    Table(of: Activity.self) {
                        TableColumn("Título", value: \.titulo)
                        TableColumn("Descrição", value: \.descricao)

                    } rows: {
                        ForEach(activities) { activity in
                            TableRow(activity)
                                
                        }
                    }
                    
                }.onAppear() {
                    Task{
                        
                        do {
                            
                          try await getAtividades()
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                    }
                }
                
            }
        
        }
    
    }
    
    func getAtividades() async throws {
        let atividades = try await service.retornaAtividades(1)
        self.activities = atividades
    }
}

struct ActivitiesListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesListView(activities: [])
    }
}
