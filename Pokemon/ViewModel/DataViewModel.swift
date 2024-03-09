//
//  DataViewModel.swift
//  Pokemon
//
//  Created by Tiga on 9.03.2024.
//

import Foundation
import UIKit

class DataViewModel {

    var datas: [Pokemon] = [Pokemon]()
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?

    private var cellViewModels: [DataListCellViewModel] = [DataListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }

    func getData(){
        showLoading?()
        ApiClient.getDataFromServer { rslt in
            DispatchQueue.main.async {
                switch rslt {
                case .success(let response):
                    self.createCell(datas: response)
                    self.reloadTableView?()
                    print("xxx Pokemons could not be fetched")

                case .failure(let error):
                    print("Pokemons could not be fetched: \(error)")
                }
            }
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }

    func getCellViewModel( at indexPath: IndexPath ) -> DataListCellViewModel {
        return cellViewModels[indexPath.row]
    }

    func createCell(datas: [Pokemon]){
        self.datas = datas
        var vms = [DataListCellViewModel]()
        for data in datas {
            vms.append(DataListCellViewModel(id: data.id, name: data.name, info: data.info, imageUrl: data.imageUrl))
        }
        cellViewModels = vms
    }
}

struct DataListCellViewModel {
    let id: Int8
    let name: String
    let info: String
    var imageUrl: String
    var imageData: Data?
}
