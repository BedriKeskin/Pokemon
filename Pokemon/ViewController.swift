//
//  ViewController.swift
//  Pokemon
//
//  Created by Tiga on 16.01.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
           super.viewDidLoad()

        print("xxxx")

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
}

