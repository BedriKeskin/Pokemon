//
//  TableViewCell.swift
//  Pokemon
//
//  Created by Bedri Keskin on 17.01.2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var picture: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var info: UILabel!
    
    static let cellIdentifier = "cellIdentifier";

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
