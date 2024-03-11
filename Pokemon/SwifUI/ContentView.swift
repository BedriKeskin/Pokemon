//
//  ContentView.swift
//  Pokemon
//
//  Created by Tiga on 9.03.2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var apiClient = ApiClient()

    var body: some View {
        NavigationStack {
            if apiClient.loading {
                Text("Loading ...")
            } else {
                List(apiClient.pokemons.results) { pokemon in
                    ListItem(pokemon: pokemon)
                        .background(NavigationLink("", destination: Details(pokemon: pokemon)).opacity(0))
                        .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())

                .navigationTitle(Globals.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.init(Globals.topBarColor), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)

                .toolbar {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "swift")
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
