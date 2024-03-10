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

            HStack {
                Text("Description").foregroundColor(.gray)
                Spacer()
            }
            Text(pokemon.name).lineLimit(nil)
            Spacer()
            Text(pokemon.info).lineLimit(nil)
        }.navigationBarTitle(Text(pokemon.name), displayMode: .inline)
            .padding()
    }
}

