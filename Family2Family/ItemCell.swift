//
//  ItemCell.swift
//  Family2Family
//
//  Created by Angelo Basa on 6/2/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
