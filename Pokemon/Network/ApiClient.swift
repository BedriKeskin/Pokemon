//
//  ApiClient.swift
//  Pokemon
//
//  Created by Tiga on 9.03.2024.
//

import Foundation

public struct ApiClient {
    static let serverURL = "https://gist.githubusercontent.com/DavidCorrado/8912aa29d7c4a5fbf03993b32916d601/raw/681ef0b793ab444f2d81f04f605037fb44814125/pokemon.json"

    static func getDataFromServer(completion: @escaping(Result<[Pokemon], Error>) -> Void) {
        print("pokemonList")

        guard let url = URL(string: serverURL) else { return }

        var request = URLRequest(url: (url))
        request.httpMethod = "GET"

        let _: Void = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let data = data, error == nil {
                do {
                    let rslt = try JSONDecoder().decode([Pokemon].self, from: data)
                    completion(.success(rslt))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error! as NSError))
            }
        }.resume()
    }
}
