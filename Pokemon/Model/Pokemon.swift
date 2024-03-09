//
//  Pokemon.swift
//  Pokemon
//
//  Created by Tiga on 9.03.2024.
//

import Foundation

struct Pokemon: Decodable {
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

    func imageFromUrl(urlString: String) -> Data? {
        print("ffffff")
        var imageData: Data?
        if let url = URL(string: urlString) {
            let _: Void = URLSession.shared.dataTask(with: url) { data, response, error in
                print("ffffff error \(error)")
                guard let data = data, error == nil else { return }
                print("ffffff data \(data)")
                imageData = data
            }.resume()
        }
        return imageData
    }
}
