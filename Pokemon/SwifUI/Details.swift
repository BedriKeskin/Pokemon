//
//  Details.swift
//  Pokemon
//
//  Created by Tiga on 10.03.2024.
//

import SwiftUI

struct Details : View {
    var pokemon: Pokemon

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.imageUrl))
            Text(pokemon.info).padding()
            Spacer()
        }.navigationBarTitle(Text(pokemon.name), displayMode: .inline)
    }
}
