//
//  CartViewController.swift
//  Family2Family
//
//  Created by Adriana Meza on 6/4/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit
import Parse

class CartViewController: UIViewController {

    var shoppingCart = [String: Int]()
    var familyData = [String: String]()
    var items = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(shoppingCart)
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

            let query = PFQuery(className: "Items")
            query.whereKey("objectId", equalTo:"Ne5lGlM5e4")
            //TO DO: Change filter to bring all items in Shopping cart in one query
            query.findObjectsInBackground { (items, error) in
                if items != nil{
                    self.items = items!
                    
                }else if let error = error {
                    // Log details of the failure
                    print(error.localizedDescription)
                }
            }
        }
        //Data --> to show in Table view
        //Items: objectId, store, price, name, qty, category
        //Somehow merge with count in shoppingCart
        
        
    func getFamily (){
        let defaults = UserDefaults.standard
        self.familyData = defaults.object(forKey: "familydata") as! [String: String]
    }
    @IBAction func onPlaceOrder(_ sender: Any) {
        //User: objectId, username --> after login save objectId and username into a dictionary
        getFamily()
        print(self.familyData["username"]! as String)
        print(self.familyData["userId"]! as String)
        
        //Insert --> transactions to DB.
          //Order: family( User.objectId), total(sum price of all items in shoppingCart), fulfilled = false
          //ItemsOrder: amount(from shoppingCart), grocery (Items.objectId --> from shoppingCart, itemName (Items.name + " " + Items.store), order (Order.objectId), sellingPrice (Items.price * amount(from shoppingCart))
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


