//
//  ViewController.swift
//  Pokemon
//
//  Created by Bedri Keskin on 16.01.2024.
//

import UIKit
import Foundation
import SwiftUI

class MainViewController: UIViewController {
    var dataViewModel = DataViewModel()
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Globals.topBarColor

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        let buttonStwichToSwiftUI = UIBarButtonItem(image: UIImage(systemName: "swift"),
                                           style: UIBarButtonItem.Style.plain ,
                                           target: self, action: #selector(self.stwichToSwiftUI(_:)))
        buttonStwichToSwiftUI.tintColor = .green
        self.navigationItem.rightBarButtonItem = buttonStwichToSwiftUI

        if let tableView = Bundle.main.loadNibNamed("TableViewController", owner: self, options: nil)?.first as? UITableView {
            self.tableView = tableView
            self.tableView.dataSource = self
            self.tableView.delegate = self
        }

        initViewModel()
    }

    @objc func stwichToSwiftUI(_ sender: UIButton) {
        DispatchQueue.main.async { [weak self] in
            let vc = UIHostingController(rootView: ContentView())
            vc.modalPresentationStyle = .fullScreen

            self?.present(vc, animated: true, completion: nil)
        }
    }

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

        let cellVM = dataViewModel.getCellViewModel(at: indexPath )

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
