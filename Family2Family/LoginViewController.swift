//
//  LoginViewController.swift
//  Family2Family
//
//  Created by Adriana Meza on 5/24/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setFamily(username: String, userId: String){
        let defaults = UserDefaults.standard
        //At each log-in if the key exists already, remove it
        if defaults.object(forKey: "familydata") != nil{
            defaults.removeObject(forKey: "familydata")
        }
        //Then, add it
        let dict = ["username": username, "userId": userId]
        defaults.set(dict, forKey: "familydata")
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password){
            (user,error) in
            
            if user != nil{
                if user?.value(forKey: "type") as! NSInteger == 0{
                    self.performSegue(withIdentifier: "LogInAsFamilyMember", sender: nil)
                    
                    self.setFamily(username: username,userId:  user?.objectId as! String)
                }
                if user?.value(forKey: "type") as! NSInteger == 1{
                    self.performSegue(withIdentifier: "LogInAsDonor", sender: nil)
                }
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
