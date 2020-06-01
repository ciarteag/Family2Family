//
//  ProductCell.swift
//  Family2Family
//
//  Created by Adriana Meza on 5/31/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var storeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
