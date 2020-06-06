//
//  DonorMainViewController.swift
//  Family2Family
//
//  Created by Adriana Meza on 5/24/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit
import Parse

class DonorMainViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    var orders = [PFObject]()
    var stores = [PFObject]()
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let query = PFQuery(className: "Order")
        query.includeKeys(["family","objectId"])
        
        query.limit = 20
        query.findObjectsInBackground { (orders, error) in
            if orders != nil{
                self.orders = orders!
                self.collectionView.reloadData()

            }
            else{
                print("failed")
            }
        }
        

        
        
        
       // let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
      //  layout.minimumLineSpacing = 4
      // layout.minimumInteritemSpacing = 0
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    

    
    @IBAction func onLogout(_ sender: Any) {
         PFUser.logOut()
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonorGridCell", for: indexPath) as! DonorGridCell
        let order = orders[indexPath.item]
        let family = order["family"] as! PFObject
        cell.familyName.text = "Family: " + (family.object(forKey: "lastname") as! String)
        cell.orderTotal.text = "Total: " + (String(format: "%@",order["total"] as! CVarArg))
        let date = String(format: "%@",order["Order_placed"] as! CVarArg)
        let index = date.index(date.startIndex, offsetBy: 10)
        let mySubstring = date.prefix(upTo: index) // Hello
        cell.datePlaced.text = "Date: " + String(mySubstring)
        let x = order["fulfilled"] as! Bool
        if x == true
        {
            cell.contentView.backgroundColor = UIColor.lightGray;
        }
        else{
            cell.contentView.backgroundColor = UIColor(red: 130.0/255, green: 149.0/255, blue: 80.0/255, alpha: 1.0);
        }
        
 
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let order = orders[indexPath.item]
        let detailsViewController = segue.destination as! OrderDetailsViewController
        detailsViewController.order = order
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }

}
