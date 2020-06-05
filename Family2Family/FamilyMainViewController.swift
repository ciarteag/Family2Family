//
//  FamilyMainViewController.swift
//  Family2Family
//
//  Created by Adriana Meza on 5/24/20.
//  Copyright © 2020 Carlos Arteaga. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FamilyMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    
    var items = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate  = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Items")
        //query.limit = 20
        query.findObjectsInBackground { (items, error) in
            if items != nil{
                self.items = items!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        
        let item = items[indexPath.row]
        let objectId = item.objectId as! String
        let imageFile = item["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
    
        cell.productDescLabel.text = item["name"] as! String
        cell.storeLabel.text = item["store"] as! String
        cell.photoView.af_setImage(withURL: url)
        
        cell.configure(with: objectId)
        cell.delegate = self
        
        return cell
    }
    
    @IBAction func onLogout(_ sender: Any) {
         PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = loginViewController
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
}

extension FamilyMainViewController:ProductCellDelegate{
    func didTapButton(with objectId: String) {
        print(objectId)
    }
}
