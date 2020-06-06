//
//  CartViewController.swift
//  Family2Family
//
//  Created by Adriana Meza on 6/4/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit
import Parse

class CartViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var shoppingCart = [String: Int]()
    var familyData = [String: String]()
    var items = [PFObject]()
    var total = 0.0
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
            var idList = [String]()
            for (key,value) in shoppingCart {
                //print("key:\(key) value:\(value)")
                idList.append(key)
            }
        
            let query = PFQuery(className: "Items")
            query.whereKey("objectId", containedIn: idList)
            //query.whereKey("objectId", equalTo:"Ne5lGlM5e4")
            query.findObjectsInBackground { (items, error) in
                if items != nil{
                    self.items = items!
                    self.tableView.reloadData()
                    self.totalLabel.text = String(self.calculateTotal())
                }else if let error = error {
                    // Log details of the failure
                    print(error.localizedDescription)
                }
            }
            
        }
    
    func calculateTotal() -> Double{
        for item in items {
            let price = item["price"] as! Double
            let qty = shoppingCart[item.objectId!]
            total = total + (Double(qty!) * price)
        }
        //print(String(total))
        return total
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell") as! CartItemCell
        let cartItem = items[indexPath.row]
        
        cell.itemNameLabel.text = cartItem["name"] as! String
        cell.priceLabel.text = String(cartItem["price"] as! Double)
        
        let key = cartItem.objectId!
        let qty = shoppingCart[key]!
        
        cell.qtyLabel.text = String(qty)
        
        return cell
    }
    
    func getFamily (){
        let defaults = UserDefaults.standard
        self.familyData = defaults.object(forKey: "familydata") as! [String: String]
    }
    
    @IBAction func onPlaceOrder(_ sender: Any) {
        
        //Insert --> transactions to DB.
          //Order: family( User.objectId), total(sum price of all items in shoppingCart), fulfilled = false
          //ItemsOrder: amount(from shoppingCart), grocery (Items.objectId --> from shoppingCart, itemName (Items.name + " " + Items.store), order (Order.objectId), sellingPrice (Items.price * amount(from shoppingCart))

        // Create Order
        do{
            //Retrieve Family
            getFamily()
            let query = PFUser.query()!
            let famObjectId = familyData["userId"]! as String
            query.whereKey("objectId", equalTo: famObjectId )
            let familyPointer = try query.getFirstObject()
            
            //Save Order
            let order = PFObject(className:"Order")
            order["total"] = total
            order["fulfilled"] = false
            order["family"] = familyPointer
            order["Order_placed"] = Date()
            
            do{
                //Master
                try order.save()
                messageLabel.isHidden = false
                
                //Detail
                for item in self.items{
                    do{
                        let itemqry = PFQuery(className:"Items")
                        itemqry.whereKey("objectId", equalTo: item.objectId!)
                        let itemPointer = try itemqry.getFirstObject()
                        
                        //Save ItemOrders
                        let itemOrder = PFObject(className:"ItemOrder")
                        itemOrder["grocery"] = itemPointer
                        let price = item["price"] as! Double
                        let qty = self.shoppingCart[item.objectId!]
                        itemOrder["amount"] = String(qty!)
                        itemOrder["sellingPrice"] = Double(qty!) * price
                        
                        let itemName = (item["name"] as! String) + " " + (item["store"] as! String)
                        itemOrder["itemName"] = itemName
                        itemOrder["order"] = order
                        
                        /*do{
                            try itemOrder.save()
                        }catch{
                            print("failed to save item")
                        }*/
                        
                        itemOrder.saveInBackground { (sucess, error) in
                            if sucess {
                                print(item.objectId! + " saved")
                            }else{
                                print(error?.localizedDescription)
                            }
                        }
                    }catch{
                        print("query to get itemPointer failed.")
                    }
                }
            }catch{
                print("query to get orderPointer failed.")
            }

        }catch{
            
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


