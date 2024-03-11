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
            Text("")
                .toolbar {
                    Button("UIKit")
                    {
                        dismiss()
                    }
                    .background(Color.red)
                    .tint(Color.white)
                }
                .navigationTitle("Pokémon")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.orange, for: .navigationBar, .tabBar)

            if apiClient.loading {
                Text("Loading ...")
            } else {
                List(apiClient.pokemons.results) { pokemon in
                    ListItem(pokemon: pokemon)
                        .background(NavigationLink("", destination: Details(pokemon: pokemon))
                            .opacity(0)).listRowSeparator(.hidden)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
