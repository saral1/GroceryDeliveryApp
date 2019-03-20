//
//  CartViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-09.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

/*
protocol SendnameBackProtocol {
    func changeLabelBack(labelText: String)
}*/

var cartGroceries = [Grocery]();
var cartGroceryIndex = 0;


class CartViewController: UIViewController, HomeModelDelegate2, UITableViewDataSource,
    UITableViewDelegate{
    
    var passedText: String?
    var User: String?
    
    //var delegate: SendnameBackProtocol?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    //MARK - starting here
    @IBOutlet var tableView: UITableView!
    
    var homeM = homeModel()
    //var groceries = [Grocery]()
    
    var cartTotal = 0.00;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set self as the tableview's data source and delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        //call getAllGrocery
        nameLabel.text = custUsername;
        User = custUsername;
        homeM.getCart(_user: User!);
        homeM.delegate2 = self

    }
    
    func getCart(grocery: [Grocery]){
        cartGroceries = grocery;
        print(cartGroceries);
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func makeOrder(_ sender: Any) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.64.2/Projects/Includes/makeOrder.php")! as URL)
        request.httpMethod = "POST"
        
        //a = user
        //b = totalPrice
        let postString = "a=\(nameLabel.text!)&b=\(totalLabel.text!)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            //print("response = \(response)")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("responseString = \(responseString)")
        }
        task.resume()
        //if you want a pop up
        let alertController = UIAlertController(title: "", message:
            "Confirmed Order", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func backButt(_ sender: Any) {
        //delegate?.changeLabelBack(labelText: User!);
        //self.dismiss(animated: true, completion: nil);
        performSegue(withIdentifier: "GoBackToCust1", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartGroceries.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
        
        var s = cartGroceries[indexPath.row].sku
        s.append("  ");
        let name = cartGroceries[indexPath.row].name;
        var counter = 0;
        for i in name.unicodeScalars{
            if(counter >= 6){
                break;
            }
            s.append("\(i)");
            counter = counter+1;
        }
        s.append("     ");
        s.append(cartGroceries[indexPath.row].sPrice);
        s.append("     ");
        s.append(cartGroceries[indexPath.row].quantity);
        s.append("     ");
        let totalPrice = Double(cartGroceries[indexPath.row].sPrice)! * Double (cartGroceries[indexPath.row].quantity)!;
        cartTotal += totalPrice;
        NSLog("\n" + String(cartTotal));
        self.totalLabel.text = String(self.cartTotal);
        let temp = String(Double(totalPrice));
        s.append(temp);
        cell.textLabel!.text = s
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cartGroceryIndex = indexPath.row;
        performSegue(withIdentifier: "GoToCartItem", sender: self);
    }
    
    
}
