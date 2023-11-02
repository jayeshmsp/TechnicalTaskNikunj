//
//  ContentView.swift
//  Technical_Nikunj_Task
//
//  Created by MSP on 02/11/23.
//

import SwiftUI
import Apollo

class ViewModel : ObservableObject {
    private(set) lazy var apollo: ApolloClient = {
        let url = URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!
        return ApolloClient(url: url)
    }()
    var starWarArr = [QueryQuery.Data.AllFilm.Film?]()
    func callApi() {
        apollo.fetch(query: QueryQuery()) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let graphQLResult):
                    print("Success! Result: \(graphQLResult)")
                    if let arr = graphQLResult.data?.allFilms?.films {
                        self.starWarArr = arr
                    }
                case .failure(let error):
                    print("Failure! Error: \(error)")
                }
            }
            
        }
    }
}


struct StarWarListView: View {
    @StateObject var viewModel = ViewModel()
    @State private var searchText = ""
    @State var starWarArr = [QueryQuery.Data.AllFilm.Film?]()

    var body: some View {
        NavigationStack {
            List(searchResults, id: \.?.title) { dataType in
                NavigationLink {
                    StarWarDetailView(objData: dataType)
                } label: {
                    Text(dataType?.title ?? "")
                }
            }
            .navigationTitle("Star Wars Films")
        }
        .searchable(text: $searchText)
        .onAppear {
            viewModel.apollo.fetch(query: QueryQuery()) {result in
                switch result {
                case .success(let graphQLResult):
                    print("Success! Result: \(graphQLResult)")
                    if let arr = graphQLResult.data?.allFilms?.films {
                        starWarArr = arr
                    }
                case .failure(let error):
                    print("Failure! Error: \(error)")
                }
            }
        }
    }
        
    var searchResults: [QueryQuery.Data.AllFilm.Film?] {
            if searchText.isEmpty {
                return starWarArr
            } else {
                return starWarArr.filter { $0?.title?.contains(searchText) ?? false}
            }
        }
     
}

#Preview {
    StarWarListView()
}
