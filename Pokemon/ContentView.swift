//
//  ContentView.swift
//  Pokemon
//
//  Created by Tiga on 9.03.2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject var dataViewModel = DataViewModel()



    var body: some View {
        NavigationStack {
            Text("SwiftUI")
//            List(networkManager.movies.results) { movie in
//                NavigationLink(destination: MovieDetails(movie: movie)){
//                    MovieRow(movie: movie)
//                }
//            }

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
        }
        .tabItem {
            Label("Rows", systemImage: "list.bullet")
        }
    }
}

#Preview {
    ContentView()
}
