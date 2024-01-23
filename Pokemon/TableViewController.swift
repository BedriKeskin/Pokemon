//
//  TableViewController.swift
//  Pokemon
//
//  Created by Bedri Keskin on 19.01.2024.
//

import UIKit

class TableViewController: UITableViewController {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

    lazy var myTableViewDataSource: MyTableViewDataSource = {
            MyTableViewDataSource()
        }()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoadviewDidLoadviewDidLoad")

        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)
        tableView.dataSource = myTableViewDataSource


//        tableView.delegate = self
//        tableView.dataSource = self

//        let nib = UINib(nibName: "TableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: TableViewCell.cellIdentifier)

        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

final class MyTableViewDataSource: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("ccccccccc \(pokemons.count)")
        return pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("ddddddd")

        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell

        cell.picture.imageFromUrl(urlString: pokemons[indexPath.row].imageUrl)
        cell.name.text = pokemons[indexPath.row].name
        cell.info.text = pokemons[indexPath.row].description
        cell.backgroundColor = UIColor.cyan

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 1030
      }
}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let task: Void = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }

                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
