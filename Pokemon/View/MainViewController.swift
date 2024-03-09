//
//  ViewController.swift
//  Pokemon
//
//  Created by Bedri Keskin on 16.01.2024.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    lazy var tableViewController: TableViewController = {
        TableViewController()
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("MainViewController açıldı.")

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

    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController

        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }

        return topMostViewController
    }
}

extension MainViewController: CustomDelegate {
    func didSelectItem(record: Pokemon) {
        print("didSelectItem \(record.name)")
        let detailsViewController = DetailsViewController(nibName: "\(DetailsViewController.self)", bundle: nil)
        detailsViewController.pokemon = record
        detailsViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        DispatchQueue.main.async {
            self.getTopMostViewController()?.present(detailsViewController, animated: true, completion: nil)
        }
    }
}
