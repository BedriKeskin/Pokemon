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
    lazy var tableViewController: TableViewController = {
        TableViewController()
    }()

    fileprivate let serverURL = "https://gist.githubusercontent.com/DavidCorrado/8912aa29d7c4a5fbf03993b32916d601/raw/681ef0b793ab444f2d81f04f605037fb44814125/pokemon.json"

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonList() { rslt in
            DispatchQueue.main.async {
                switch rslt {
                case .success(let response):
                    pokemons = response
                    self.showTable()
                case .failure(let error):
                    print("Pokemons could not be fetched: \(error)")
                }
            }
        }
    }

    private func showTable() {
        if let tableView = Bundle.main.loadNibNamed("\(TableViewController.self)", owner: self, options: nil)?.first as? UITableView {
            tableView.dataSource = tableViewController.myTableViewDataSource
            tableView.delegate = tableViewController.myDelegate
        }
    }

    private func pokemonList(completion: @escaping(Result<[Pokemon], Error>) -> Void) {
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

extension ViewController: CustomDelegate {
    func didSelectItem(record: Pokemon) {
        let detailsViewController = DetailsViewController(nibName: "\(DetailsViewController.self)", bundle: nil)
        detailsViewController.pokemon = record
        let currentViewController = UIApplication.shared.keyWindow?.rootViewController
        detailsViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        currentViewController?.present(detailsViewController, animated: true, completion: nil)
    }
}

struct Pokemon: Decodable {
    let id: Int8
    let name: String
    let description: String
    let imageUrl: String
}
