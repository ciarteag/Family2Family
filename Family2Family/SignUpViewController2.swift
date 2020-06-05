//
//  SignUpViewController2.swift
//  Family2Family
//
//  Created by Adriana Meza on 6/4/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController2: UIViewController {

    var accountData = [0: "", 1: "",] //user, password
    var personalData = [0: "", 1: "", 3: "", 4: ""] //name, lastname, email, phone number
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var accountType: UISegmentedControl!
    @IBOutlet weak var shippingInfoContainer: UIView!
    @IBOutlet weak var addressLine1Field: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var addressLine2Field: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Collect Account data: user, password
        print(accountData)
        //Collect Personal data: name, lastname, email, phone number
        print(personalData)
        
        messageLabel.isHidden = true;
        shippingInfoContainer.isUserInteractionEnabled =
            (accountType.selectedSegmentIndex == 0);
    }
    
    @IBAction func onAccountTypeChanged(_ sender: Any) {
        addressLine1Field.text = ""
        addressLine2Field.text = ""
        cityField.text = ""
        stateField.text = ""
        zipCodeField.text = ""
        
        shippingInfoContainer.isUserInteractionEnabled =
             (accountType.selectedSegmentIndex == 0);
        
        addressLine1Field.isEnabled = (accountType.selectedSegmentIndex == 0);
        addressLine2Field.isEnabled = (accountType.selectedSegmentIndex == 0);
        cityField.isEnabled = (accountType.selectedSegmentIndex == 0);
        stateField.isEnabled = (accountType.selectedSegmentIndex == 0);
        zipCodeField.isEnabled = (accountType.selectedSegmentIndex == 0);
    }
    
    func checkAccountData() -> Bool {
       let complete = (accountData[0] != "" && accountData[1] != "")
       return complete
    }
    
    func checkPersonalData() -> Bool {
       let complete = (personalData[0] != "" && personalData[1] != "" && personalData[2] != "")
       return complete
    }
    
    //TO DO: complete value
    func checkShippingAddress() -> Bool {
       var complete = true
        if let text = addressLine1Field.text, text.isEmpty {
           complete = false
        }
        if let text = cityField.text, text.isEmpty {
           complete = false
        }
        if let text = stateField.text, text.isEmpty {
           complete = false
        }
        if let text = zipCodeField.text, text.isEmpty {
           complete = false
        }
       return complete
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        //validate account and personal data
        if checkAccountData() == false {
            print("Account data is incomplete")
            self.messageLabel.text = "Ups... account info is incomplete."
            self.messageLabel.isHidden = false;
            return;
        }
        if checkPersonalData() == false {
            print("Personal data is incomplete")
            self.messageLabel.text = "Ups... personal info is incomplete."
            self.messageLabel.isHidden = false;
            return;
        }
        //validate shipping info is complete for family members
        if accountType.selectedSegmentIndex == 0 && checkShippingAddress() == false{
            print("Shipping data is incomplete")
            self.messageLabel.text = "Ups... shipping info is incomplete."
            self.messageLabel.isHidden = false;
            return;
        }
        
        let user = PFUser();
        
        //Account Data
        user.username = accountData[0]
        user.password = accountData[1]
        
        //Personal Data
        user["firstname"] = personalData[0]
        user["lastname"] = personalData [1]
        user.email = personalData [2] //"email@example.com"
        user["phone"] = personalData[3] //"415-392-0202"
        user["type"] = accountType.selectedSegmentIndex //0  //0:family member, 1:donor
        
        //Shipping Data
        user["address1"] = addressLine1Field.text
        user["address2"] = addressLine2Field.text
        user["city"] = cityField.text
        user["state"] = stateField.text
        user["zipcode"] = zipCodeField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                print("A new user has been created.")
                self.messageLabel.text = "Your account is ready!"
                self.messageLabel.isHidden = false;
            }else{
                print("Error: \(error?.localizedDescription)")
            }
        }
        
    }
    
    @IBAction func returnToSignIn(_ sender: Any) {
        //Return to Log In VC
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = loginViewController
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
