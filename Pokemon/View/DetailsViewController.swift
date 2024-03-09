//
//  DetailsViewController.swift
//  Pokemon
//
//  Created by Tiga on 23.01.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet var Image: UIImageView!
    @IBOutlet var Info: UILabel!

    var pokemon: DataListCellViewModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        if let pokemon = pokemon {
            self.title = pokemon.name

            pokemon.retrieveImage { image, error in
                DispatchQueue.main.sync {
                    self.Image.image = image
                }
            }

            Info.text = pokemon.info
        }
    }
}
