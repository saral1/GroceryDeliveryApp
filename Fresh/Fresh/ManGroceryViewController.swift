//
//  ManGroceryViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-12.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

var manGroceries = [Grocery](); //empty grocery array
var manGroceryIndex = 0;

class ManGroceryViewController: UIViewController, HomeModelDelegate, UITableViewDataSource, UITableViewDelegate{
    
    var homeM = homeModel()
    var groceries = [Grocery]() //empty grocery array
    
    @IBOutlet var username: UILabel!
    @IBOutlet var tableView: UITableView!

    var passedText: String?
    var User: String?
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "BackToMan1", sender: self);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set self as the tableview's data source and delegate
        tableView.delegate = self
        tableView.dataSource = self

        //call getAllGrocery
        homeM.delegate = self
        homeM.getAllGrocery();
        
        User = manUsername;
        username.text = manUsername;
    }
    
    func getAllGrocery(grocery: [Grocery]) {
        manGroceries = grocery;
        print(manGroceries);
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manGroceries.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manGroceryCell", for: indexPath)
        var s = manGroceries[indexPath.row].sku
        s.append("     ");
        let name = manGroceries[indexPath.row].name;
        var counter = 0;
        for i in name.unicodeScalars{
            if(counter >= 8){
                break;
            }
            s.append("\(i)");
            counter = counter+1;
        }
        s.append("      ");
        s.append(manGroceries[indexPath.row].sPrice);
        s.append("      ");
        s.append(manGroceries[indexPath.row].quantity);
        cell.textLabel!.text = s
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        manGroceryIndex = indexPath.row;
        performSegue(withIdentifier: "GoToEditGrocery", sender: self);
    }
    
    
}

