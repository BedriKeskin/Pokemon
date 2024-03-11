//
//  ApiClient.swift
//  Pokemon
//
//  Created by Tiga on 9.03.2024.
//

import Foundation

public class ApiClient: ObservableObject {
    @Published var pokemons = Pokemons(results: [])
    @Published var loading = false

    init() {
        loading = true
        getDataFromServer{ rslt in
            DispatchQueue.main.async {
                switch rslt {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.pokemons = Pokemons(results: response)
                        print("aaa self.pokemons \(self.pokemons)")
                        self.loading = false
                    }
                case .failure(let error):
                    print("Pokemons could not be fetched: \(error)")
                }
            }
        }
    }

    func getDataFromServer(completion: @escaping(Result<[Pokemon], Error>) -> Void) {
        guard let url = URL(string: Globals.serverURL) else { return }

        var request = URLRequest(url: (url))
        request.httpMethod = "GET"

        let _: Void = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let data = data, error == nil {
                do {
                    let result = try JSONDecoder().decode([Pokemon].self, from: data)

                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error! as NSError))
            }
        }.resume()
    }
}
