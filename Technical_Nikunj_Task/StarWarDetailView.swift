//
//  StarWarDetailView.swift
//  Technical_Nikunj_Task
//
//  Created by MSP on 02/11/23.
//

import SwiftUI

struct StarWarDetailView: View {
    
    
    let objData: QueryQuery.Data.AllFilm.Film?
    
    func fetchCharacters() -> String {
        var str = ""
        for obj in (objData?.characterConnection?.characters ?? [QueryQuery.Data.AllFilm.Film.CharacterConnection.Character]()) {
            str.append("- \(obj?.name ?? "")\n")
        }
        return str
    }

    private let startAnimationDuration = 5.0
    @State private var animationStart = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    HStack{
                        Text("Episode Number :")
                            .font(.body)
                            .fontWeight(.heavy)
                            .frame(alignment: .leading)
                            .padding()
                        Text("\(objData?.episodeId ?? 0)")
                            .font(.body)
                        Spacer()
                    }
                    Text(objData?.openingCrawl ?? "")
                            .frame(alignment: .center)
                    
                    
                    HStack{
                        Text("Characters :")
                            .font(.body)
                            .fontWeight(.heavy)
                            .frame(alignment: .leading)
                            .padding()
                        Spacer()
                    }
                    HStack{
                        Text(fetchCharacters())
                            .font(.body).padding()

                        Spacer()
                    }
                    
                }
                Spacer()
            }
        }.navigationTitle(objData?.title ?? "")
    }
}

//#Preview {
//    StarWarDetailView(objData: <#T##QueryQuery.Data.AllFilm.Film?#>)
//}
