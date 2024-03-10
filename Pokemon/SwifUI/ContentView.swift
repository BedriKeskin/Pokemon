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

    @StateObject var dataViewModel = DataViewModel()

    var body: some View {
        NavigationStack {
            Text("SwiftUI")
                .toolbar {
                    Button("UIKit")
                    {
                        dismiss()
                    }
                    .background(Color.red)
                    .tint(Color.white)
                }
                .navigationTitle("Pokemon")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.orange, for: .navigationBar, .tabBar)


            if apiClient.loading {
                Text("Loading ...")
            } else {
                Text("x pokemons \(apiClient.pokemons.results.count )")
                List(apiClient.pokemons.results) { pokemon in
                    NavigationLink(destination: Details(pokemon: pokemon)){
                        ListItem(pokemon: pokemon)
                    }
                }
            }
        }
        .tabItem {
            Label("Rows", systemImage: "list.bullet")
        }
    }
}

#Preview {
    ContentView()
}
