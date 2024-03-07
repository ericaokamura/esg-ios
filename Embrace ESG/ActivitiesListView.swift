//
//  ActivitiesListView.swift
//  Embrace ESG
//  Created by Erica Okamura on 01/03/24.
//

import SwiftUI

struct ActivitiesListView: View {

    var body: some View {
    
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    Text("Atividades Cadastradas")
                        .foregroundColor(Color.indigo)
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .padding(50)
                
                    ActivityTableView()
                    
                }
            }
        }
    }

}

struct ActivitiesListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesListView()
    }
}
