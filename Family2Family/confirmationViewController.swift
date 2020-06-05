//
//  confirmationViewController.swift
//  Family2Family
//
//  Created by Angelo Basa on 6/4/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit

class confirmationViewController: UIViewController {
    
    @IBOutlet weak var thanksImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    var familyName = String();

    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = "Your payment has been confirmed for the " + familyName + " family! Thank you for your generosity!"

        // Do any additional setup after loading the view.
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
