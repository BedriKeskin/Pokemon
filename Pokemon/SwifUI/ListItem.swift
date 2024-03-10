//
//  ListItem.swift
//  Pokemon
//
//  Created by Tiga on 10.03.2024.
//

import SwiftUI

struct ListItem : View {
    var pokemon: Pokemon

    var body: some View {
        HStack {
            VStack {
                HStack {
                    AsyncImage(url: URL(string: pokemon.imageUrl))
                    VStack {
                        Text(pokemon.name).bold()
                        Text(pokemon.info)
                    }
                }
            }
        }
    }
}
