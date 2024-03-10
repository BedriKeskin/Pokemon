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
                Spacer()
                HStack {
                    Text(pokemon.name)
                        .foregroundColor(.blue)
                        .lineLimit(nil)
                    Spacer()
                }
                HStack {
                    Text(pokemon.info).foregroundColor(.gray)
                    Spacer()
                    Text("Rate: \(pokemon.imageUrl)")
                }
                HStack {
                    Text("Vote count: \(pokemon.id)")
                        .foregroundColor(.gray)
                        .lineLimit(nil)
                    Spacer()
                }
            }
        }.frame(height: 130)
    }
}
