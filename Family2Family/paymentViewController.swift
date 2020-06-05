//
//  paymentViewController.swift
//  Family2Family
//
//  Created by Angelo Basa on 6/4/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit
import Parse

class paymentViewController: UIViewController {
    var familyName = String();
    var Order = PFObject(className: "Order");
    

    @IBOutlet weak var payButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        payButton.setTitle("Confirm Order",for: .normal)
        

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let x = segue.destination as! confirmationViewController
    x.familyName = familyName;
        x.order = Order;
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
