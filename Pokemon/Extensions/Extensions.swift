//
//  UIViewController+Extensions.swift
//  Pokemon
//
//  Created by Tiga on 9.03.2024.
//

import UIKit

extension UIViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
