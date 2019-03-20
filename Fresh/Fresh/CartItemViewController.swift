//
//  CartItemViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-10.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

class CartItemViewController: UIViewController{
    
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var skuLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    var ogQuantity = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        userLabel.text = custUsername;
        skuLabel.text = cartGroceries[cartGroceryIndex].sku;
        nameLabel.text = cartGroceries[cartGroceryIndex].name;
        priceLabel.text = cartGroceries[cartGroceryIndex].sPrice;
        quantityLabel.text = cartGroceries[cartGroceryIndex].quantity;
        ogQuantity = Int(cartGroceries[cartGroceryIndex].quantity)!;
        let totalPrice = Double(cartGroceries[cartGroceryIndex].sPrice)! * Double (cartGroceries[cartGroceryIndex].quantity)!;
        totalLabel.text = String(totalPrice);
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "BackToCart", sender: self);
    }
    
    @IBAction func deleteFromCart(_ sender: Any) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.64.2/Projects/Includes/deleteFromCart.php")! as URL)
        request.httpMethod = "POST"
        
        //a = user
        //b = sku
        let postString = "a=\(userLabel.text!)&b=\(skuLabel.text!)"
        
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
            "Deleted from cart", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
