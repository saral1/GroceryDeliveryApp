//
//  allStoreViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-12.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

var storeArray = [Store](); //empty grocery array
var storeArrayIndex = 0;

class allStoreViewController: UIViewController, HomeModelDelegate3, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var username: UILabel!
    
    
    var homeM = homeModel()
    var store = [Store]() //empty grocery array
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "BackToMan3", sender: self);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.delegate = self;
        tableView.dataSource = self;
        homeM.getAllStore();
        homeM.delegate3 = self;
        username.text = manUsername;
    }
    
    func getAllStore(store: [Store]) {
        storeArray = store;
        print(storeArray);
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath)
        
        var s = storeArray[indexPath.row].storeid;
        s.append("  ");
        let street = storeArray[indexPath.row].street;
        var counter = 0;
        for i in street.unicodeScalars{
            if(counter >= 6){
                break;
            }
            s.append("\(i)");
            counter = counter+1;
        }
        s.append("     ");
        s.append(storeArray[indexPath.row].city);
        s.append("     ");
        s.append(storeArray[indexPath.row].province);
        s.append("     ");
        s.append(storeArray[indexPath.row].phone);
        cell.textLabel!.text = s
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        storeArrayIndex = indexPath.row;
        performSegue(withIdentifier: "GoToStoreDetails", sender: self);
    }
}
