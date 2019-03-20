//
//  ShopViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-09.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

/*
protocol SendNameBackProtocol {
    func changeLabelBack(labelText: String)
}
 */

var shopGroceries = [Grocery]() //empty grocery array
var shopGroceryIndex = 0;

class ShopViewController: UIViewController, HomeModelDelegate, UITableViewDataSource, UITableViewDelegate{
    
    var homeM = homeModel()
    var groceries = [Grocery]() //empty grocery array
    @IBOutlet var username: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    var passedText: String?
    var User: String?
    
    //var delegate: SendNameBackProtocol?
    
    @IBAction func backButton(_ sender: Any) {
       // delegate?.changeLabelBack(labelText: User!);
       // self.dismiss(animated: true, completion: nil);
        performSegue(withIdentifier: "GoBackToCust2", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set self as the tableview's data source and delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        //call getAllGrocery
        homeM.getAllGrocery()
        homeM.delegate = self
        
        User = custUsername;
        username.text = custUsername;
    }
    
    func getAllGrocery(grocery: [Grocery]) {
        shopGroceries = grocery;
        print(shopGroceries);
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopGroceries.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        //let strLength = strlen(shopGroceries[indexPath.row].name);
        //let numberSpace = 20 - strLength;
        var s = shopGroceries[indexPath.row].sku
        s.append("     ");
        let name = shopGroceries[indexPath.row].name;
        var counter = 0;
        for i in name.unicodeScalars{
            if(counter >= 8){
                break;
            }
            s.append("\(i)");
            counter = counter+1;
        }
        s.append("      ");
        s.append(shopGroceries[indexPath.row].sPrice);
        //let strLength2 = strlen(shopGroceries[indexPath.row].sPrice);
        //let numberSpace2 = 8 - strLength2;
        //for _ in 0...numberSpace2{
            s.append("      ");
        //}
        s.append(shopGroceries[indexPath.row].quantity);
        cell.textLabel!.text = s
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shopGroceryIndex = indexPath.row;
        performSegue(withIdentifier: "GoToAddToCart", sender: self);
    }
    
    
}
