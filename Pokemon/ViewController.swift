//
//  ViewController.swift
//  Pokemon
//
//  Created by Bedri Keskin on 16.01.2024.
//

import UIKit
import Foundation

var pokemons: Array<Pokemon> = []

class ViewController: UIViewController {
    fileprivate let shared = URLSession.shared
    fileprivate let serverURL = "https://gist.githubusercontent.com/DavidCorrado/8912aa29d7c4a5fbf03993b32916d601/raw/681ef0b793ab444f2d81f04f605037fb44814125/pokemon.json"


    override func viewDidLoad() {
        super.viewDidLoad()

//        getDataFromServer()

        userList() { rslt in
            switch rslt {
            case .success(let response):

                pokemons = response

                for pokemon in pokemons {
                    print("pokemon \(pokemon.name)")
                }
            case .failure(_):
                print("Check Internet Connection")
            }
        }

        if let productView = Bundle.main.loadNibNamed("\(PokemonTableViewCell.self)", owner: self, options: nil)?.first as? PokemonTableViewCell {
            self.view.addSubview(productView)

            productView.translatesAutoresizingMaskIntoConstraints = false
            //productView.Picture.image = UIImage(named: "iPhone 11")
            productView.Name.text = "iPhone 11"
            productView.Info.text = "Kullanım konusunda hiçbir karışıklığa yer vermeden tonlarca yetenekle donatılmış çığır açıcı üçlü kamera sistemi. Pil ömrü konusunda eşi benzeri görülmemiş büyüklükte bir adım."

            NSLayoutConstraint.activate([
                productView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                productView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 200),
                productView.widthAnchor.constraint(equalToConstant: 414),
                productView.heightAnchor.constraint(equalToConstant: 240)
            ])
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        let tableController = TableController()
        present(tableController, animated: true)
    }

    private func userList(completion: @escaping(Result<[Pokemon], Error>) -> Void) {
        guard let url = URL(string: serverURL) else { return }

        var request = URLRequest(url: (url))
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                do
                {
                    let rslt = try JSONDecoder().decode([Pokemon].self, from: data)
                    completion(.success(rslt))
                }
                catch
                {
                    completion(.failure(error))
                }
            }
            else {
                completion(.failure(error! as NSError))
            }
        }.resume()
    }
}

struct Pokemon: Decodable {
    let id: Int8
    let name: String
    let description: String
    let imageUrl: String

    init(id: Int8, name: String, description: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
    }
}
