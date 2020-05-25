//
//  DonorSignUpViewController.swift
//  Family2Family
//
//  Created by Adriana Meza on 5/24/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit
import Parse

class DonorSignUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCreateAccount(_ sender: Any) {
        var user = PFUser()
        
        //TEST
        /*user.username = "myUsername"
        user.password = "myPassword"
        user.email = "email@example.com"
        
        // other fields can be set just like with PFObject
        user["firstname"] = "adriana"
        user["lastname"] = "meza"
        user["phone"] = "415-392-0202"
        user["type"] = "donor"*/
        
        
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
        
        // other fields can be set just like with PFObject
        user["firsname"] = firstnameField.text
        user["lastname"] = lastnameField.text
        user["phone"] = phoneField.text //"415-392-0202"
        user["type"] = "donor"
        
        user.signUpInBackground { (success, error) in
            if success {
                print("A new user of type donor was created.")
            }else{
                print("Error: \(error?.localizedDescription)")
            }
        }
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
