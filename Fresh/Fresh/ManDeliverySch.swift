//
//  ManDeliverySch.swift
//  Fresh
//
//  Created by Sara on 2018-04-12.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

var manDelivery = [Delivery]();
var manDeliveryIndex = 0;

class ManDeliverySch: UIViewController, HomeModelDelegate4, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var username: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var homeM = homeModel();
    var store = [Delivery]();
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "BackToMan5", sender: self);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.delegate = self;
        tableView.dataSource = self;
        homeM.getAllDelivery();
        homeM.delegate4 = self;
        username.text = manUsername;
        print("HELLO");
        print(manDelivery);
    }
    
    func getAllDelivery(delivery: [Delivery]) {
        manDelivery = delivery;
        print(manDelivery);
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manDelivery.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryCell", for: indexPath)
        
        var s = manDelivery[indexPath.row].deliveryid;
        s.append("  ");
        s.append(manDelivery[indexPath.row].planneddeliverydate);
        s.append("   ");
        s.append(manDelivery[indexPath.row].actualdeliverydate);
        s.append("   ");
        s.append(manDelivery[indexPath.row].delivered);
        s.append("   ");
        s.append(manDelivery[indexPath.row].employeetodeliver);
        cell.textLabel!.text = s
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        manDeliveryIndex = indexPath.row;
        performSegue(withIdentifier: "GoToDeliveryDetail", sender: self);
    }
}
