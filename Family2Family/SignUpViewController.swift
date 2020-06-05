//
//  SignUpViewController.swift
//  Family2Family
//
//  Created by Adriana Meza on 5/24/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    var accountData = [0: "", 1: "",] //user, password
    var personalData = [0: "", 1: "", 3: "", 4: ""] //name, lastname, email, phone number
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        //Collect Account data: user, password
        self.accountData[0] = usernameField.text
        self.accountData[1] = passwordField.text
        print(accountData)
        
        //Collect Personal data: name, lastname, email, phone number
        self.personalData[0] = firstnameField.text
        self.personalData[1] = lastnameField.text
        self.personalData[2] = emailField.text
        self.personalData[3] = phoneField.text
        print(personalData)
        
        // Get the new view controller using segue.destination.
        let step2 = segue.destination as! SignUpViewController2
     
        // Pass the selected object to the new view controller.
        step2.accountData = self.accountData
        step2.personalData = self.personalData
    }
    

}
