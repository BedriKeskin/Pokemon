//
//  Pokemon.swift
//  Pokemon
//
//  Created by Tiga on 9.03.2024.
//

import Foundation
import UIKit

struct Pokemon: Decodable, Identifiable {
    let id: Int8
    let name: String
    let info: String
    let imageUrl: String

    private enum CodingKeys: CodingKey {
        case id
        case name
        case description
        case imageUrl
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int8.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        info = try container.decode(String.self, forKey: .description)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
    }
}

struct Pokemons: Decodable {
    var results: [Pokemon]
}
