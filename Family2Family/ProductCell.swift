//
//  ProductCell.swift
//  Family2Family
//
//  Created by Adriana Meza on 5/31/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit

protocol ProductCellDelegate: AnyObject {
    func didTapButton(with productId: String)
}

class ProductCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var addProductButton: UIButton!
    
    weak var delegate: ProductCellDelegate?
    //private var buttonTag: Int = 0
    private var objectId: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with objectId: String){
        
        //self.buttonTag = buttonTag
        //addProductButton.tag = buttonTag
        self.objectId = objectId
     
    }
    @IBAction func onAddProduct(_ sender: Any) {
        delegate?.didTapButton(with: objectId)
    }
}
