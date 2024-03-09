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

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        self.showTable()
    }

    func initViewModel(){
        //        dataViewModel.reloadTableView = {
        //            DispatchQueue.main.async { tableViewController.reloadData() }
        //        }
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

    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        print("viewDidAppear MainViewController açıldı.")
    //
    //    }

    private func showTable() {
        if let tableView = Bundle.main.loadNibNamed("TableViewController", owner: self, options: nil)?.first as? UITableView {
            tableView.dataSource = self
//            tableView.delegate = self
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

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell

        let cellVM = dataViewModel.getCellViewModel( at: indexPath )

        cell.picture.imageFromUrl(urlString: cellVM.imageUrl)
        cell.name.text = cellVM.name
        cell.info.text = cellVM.info
        cell.backgroundColor = UIColor.cyan

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cellVM = dataViewModel.getCellViewModel( at: indexPath )

        print("didSelectItem \(cellVM.name)")
        let detailsViewController = DetailsViewController(nibName: "\(DetailsViewController.self)", bundle: nil)
        detailsViewController.pokemon = cellVM
        detailsViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        DispatchQueue.main.async {
            self.getTopMostViewController()?.present(detailsViewController, animated: true, completion: nil)
        }
    }
}
