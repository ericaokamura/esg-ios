//
//  ActivityTableView.swift
//  Embrace ESG
//
//  Created by Erica Okamura on 07/03/24.
//

import SwiftUI

struct ActivityTableView: View {
    @State private var activities: [Activity] = []
    var service = ActivityService()

    @State private var sortOrder = [KeyPathComparator(\Activity.criadoEm)]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    Section(header: headerView()) {
                        ForEach(activities) { activity in
                            HStack {
                                Text(activity.titulo)
                                    .foregroundColor(.indigo)
                                    .frame(width: 80)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                Divider()
                                Text(activity.descricao)
                                    .foregroundColor(.indigo)
                                    .frame(width: 100)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                Divider()
                                Text(retornaCategoria(activity.categoria))
                                    .foregroundColor(.indigo)
                                    .frame(width: 200)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
                .background(Color.white)
                .listStyle(InsetGroupedListStyle())
                .task {
                    do {
                        self.activities = try await getAtividades()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .background(Color.white)
        }
    }

    func headerView() -> some View {
        HStack {
            Text("Título")
                .font(.headline)
                .frame(width: 80)
            Divider()
            Text("Descrição")
                .font(.headline)
                .frame(width: 100)
            Divider()
            Text("Categoria")
                .font(.headline)
                .frame(width: 200)
        }
    }

    func getAtividades() async throws -> [Activity] {
        return try await service.retornaAtividades(1)
    }
    
    func retornaCategoria(_ categoria: String) -> String {
        var cat = ""
        switch categoria {
            case "VOLUNTARIADO": cat = "VOLUNTARIADO"
            case "COLETA_SELETIVA": cat = "COLETA SELETIVA"
            case "CULTIVO_HORTA_DOMESTICA": cat = "CULTIVO DE HORTA DOMÉSTICA"
            case "PRATICA_ATIVIDADES_FISICAS": cat = "PRÁTICA DE ATIVIDADES FÍSICAS"
            case "HABITOS_ALIMENTARES_SAUDAVEIS": return "HÁBITOS ALIMENTARES SAUDÁVEIS"
            default: return ""
        }
        return cat
    }
}

struct ActivityTableView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ActivityTableView()
        }
    }
}
