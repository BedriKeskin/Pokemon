//
//  ViewController.swift
//  Pokemon
//
//  Created by Bedri Keskin on 16.01.2024.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    var dataViewModel = DataViewModel()
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let tableView = Bundle.main.loadNibNamed("TableViewController", owner: self, options: nil)?.first as? UITableView {
            self.tableView = tableView
            self.tableView.dataSource = self
            self.tableView.delegate = self
        }

        initViewModel()

//        let height = (self.navigationController?.navigationBar.frame.size.height)!
//        let width = (self.navigationController?.navigationBar.frame.size.width)!
//
//        let button = UIButton(frame: CGRect(x: width-width/5, y: 0, width: width/5, height: height))
//        button.backgroundColor = .red
//        button.tintColor = .white
//        button.setTitle("Switch to\nSwiftUI", for: .normal)
//        button.addTarget(self, action: #selector(change), for: .touchUpInside)
//        self.navigationController!.navigationBar.addSubview(button)
    }

//    @objc func change () {
//        print("aaaaa")
//    }

    func initViewModel() {
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        //        dataViewModel.showError = {
        //            DispatchQueue.main.async { self.showAlert("Ups, something went wrong.") }
        //        }
        //        dataViewModel.showLoading = {
        //            DispatchQueue.main.async { self.activityIndicator.startAnimating() }
        //        }
        //        dataViewModel.hideLoading = {
        //            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
        //        }
        dataViewModel.getData()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell

        let cellVM = dataViewModel.getCellViewModel( at: indexPath )

        cellVM.retrieveImage { image, error in
            DispatchQueue.main.sync {
                cell.picture.image = image
            }
        }

        cell.name.text = cellVM.name
        cell.info.text = cellVM.info

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController(nibName: "\(DetailsViewController.self)", bundle: nil)
        detailsViewController.pokemon = dataViewModel.getCellViewModel( at: indexPath )
        detailsViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
