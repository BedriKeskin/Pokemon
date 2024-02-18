//
//  TableViewController.swift
//  Pokemon
//
//  Created by Bedri Keskin on 19.01.2024.
//

import UIKit

class TableViewController: UITableViewController {

    lazy var myTableViewDataSource: MyTableViewDataSource = {
        MyTableViewDataSource()
    }()

    lazy var myDelegate: MyTableViewDelegate = {
        MyTableViewDelegate()
    }()
}

final class MyTableViewDelegate: NSObject, UITableViewDelegate {
    var delegate: (CustomDelegate)? = {
        MainViewController()
    }()

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record = pokemons[indexPath.row]
        delegate!.didSelectItem(record: record)
    }
}

protocol CustomDelegate: AnyObject {
    func didSelectItem(record: Pokemon)
}

final class MyTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell

        cell.picture.imageFromUrl(urlString: pokemons[indexPath.row].imageUrl)
        cell.name.text = pokemons[indexPath.row].name
        cell.info.text = pokemons[indexPath.row].info
        cell.backgroundColor = UIColor.cyan

        return cell
    }
}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let _: Void = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
