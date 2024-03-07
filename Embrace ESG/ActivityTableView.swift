//
//  ActivityTableView.swift
//  Embrace ESG
//
//  Created by Erica Okamura on 07/03/24.
//

import SwiftUI

struct ActivityTableView: View {
    
    @State var activities: [Activity]
    var service = ActivityService()
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isCompact: Bool { horizontalSizeClass == .compact }
    #else
    private let isCompact = false
    #endif
    
    @State private var sortOrder = [KeyPathComparator(\Activity.criadoEm)]


    var body: some View {
        
        NavigationView {
                            
            
                VStack {
                    
                    Table(activities, sortOrder: $sortOrder) {
                        TableColumn("Título") { activity in
                            HStack() {
                                if isCompact {
                                    Text(activity.descricao)
                                        .foregroundStyle(.secondary)
                                        .frame(width: 100)
                                }
                            }
                        }
                        TableColumn("Descrição") { activity in
                            HStack() {
                                if isCompact {
                                    Text(activity.descricao)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }.task {
                        do {
                            self.activities = try await getAtividades()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }

                }
                
        }
        
    }
    
    func getAtividades() async throws -> [Activity] {
        let atividades = try await service.retornaAtividades(1)
        return atividades
    }
}

struct ActivityTableView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTableView(activities: [])
    }
}
