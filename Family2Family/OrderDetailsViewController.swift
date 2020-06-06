//
//  OrderDetailsViewController.swift
//  Family2Family
//
//  Created by Angelo Basa on 5/31/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit
import Parse

class OrderDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    
    var order = PFObject.init(className: "Order")
    var items = [PFObject]()
    var stores = [String]()
    
    @IBOutlet weak var fulfillLabel: UILabel!
    
    @IBOutlet weak var fulfillButton: UIButton!
    
    @IBOutlet weak var orderTotal: UILabel!
    
    @IBOutlet weak var familyName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    let family = order["family"] as! PFObject
        familyName.text = family.object(forKey: "lastname") as? String
        familyName.text! += " Family"
        let x = order["fulfilled"] as! Bool
        if x == true{
            fulfillButton.isEnabled = false;
            fulfillLabel.text = "FULFILLED"
        }
        else{
            fulfillLabel.text = ""
        }
        orderTotal.text = "Total: $" + (String(format: "%@",order["total"] as! CVarArg))

        
        let query = PFQuery(className: "ItemOrder")
        query.limit = 20
        query.order(byDescending: "grocery")
        query.includeKeys(["order","grocery"])
        query.whereKey("order", equalTo: order)
        query.findObjectsInBackground { (items, error) in
            if items != nil{
                self.items = items!
                self.tableView.reloadData()
            }
                
            else{
                print("failed")
            }
        }
        
        

        

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        for item in items{
            let grocery = item["grocery"] as! PFObject
            let store = grocery["store"] as! String
            if(!stores.contains(store))
            {
                stores.append(store)
            }
        }
        return stores.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var items_in_store = [PFObject]()
        for item in items{
            let grocery = item["grocery"] as! PFObject
            let store = grocery["store"] as! String
            if store == stores[section]
            {
                items_in_store.append(item)
            }
        }
        return items_in_store.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        // make an array for all the items of that store
        //use index to navigate that array
          if(indexPath.row == 0)
          {
          let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemsCell", for: indexPath) as! OrderItemsCell
          
        //  let item = items[indexPath.row]
          cell.nameLabel.text = stores[indexPath.section] as!String
          return cell
                
          }
          else
          {
            let store = stores[indexPath.section] as! String
            var store_items = [PFObject]()
            for item in items
            {
                let grocery = item["grocery"] as! PFObject
                let s = grocery["store"] as! String
                if s == store
                {
                    store_items.append(item)
                }
            }
            let item = store_items[indexPath.row-1]
              let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
              
            //  let item = items[indexPath.row]
            let grocery = item["grocery"] as! PFObject
            
            cell.itemLabel.text = grocery.object(forKey: "name") as! String
            //cell.itemLabel.sizeToFit()
            cell.qtyLabel.text = String(format: "%@",item["amount"] as! CVarArg)
            cell.priceLabel.text = String(format: "%@",item["sellingPrice"] as! CVarArg)
            
              return cell
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let x = segue.destination as! paymentViewController
            let family = order["family"] as! PFObject
            let name = family.object(forKey: "lastname") as! String
            x.familyName = name;
            x.Order = order
                
        
    }
}
