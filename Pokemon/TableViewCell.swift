//
//  TableViewCell.swift
//  Pokemon
//
//  Created by Bedri Keskin on 17.01.2024.
//

import UIKit

final class TableViewCell: UITableViewCell {
    @IBOutlet var picture: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var info: UILabel!
    
    static let cellIdentifier = "cellIdentifier";

    weak var delegate: CustomDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
