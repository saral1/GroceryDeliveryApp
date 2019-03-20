//
//  GroceryItemViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-10.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

class GroceryItemViewController:UIViewController{
    
    @IBOutlet var skuLabel: UILabel!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var availQuantity: UILabel!
    @IBOutlet var quantityText: UITextField!
    
    override func viewDidLoad() {
        userLabel.text = custUsername;
        skuLabel.text = shopGroceries[shopGroceryIndex].sku;
        nameLabel.text = shopGroceries[shopGroceryIndex].name;
        priceLabel.text = shopGroceries[shopGroceryIndex].sPrice;
        availQuantity.text = shopGroceries[shopGroceryIndex].quantity;
        super.viewDidLoad();
        quantityText.text = "1";
    }
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "BackToGroceries", sender: self)
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        var quantity = Int(quantityText.text!);
        var availQuantity = Int(self.availQuantity.text!);
        if(quantity! >= availQuantity!){
            let alertController = UIAlertController(title: "Error", message:
                "Cannot add more than available quantity to cart", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        //a = user
        //b = sku
        //c = quantity to add
        else{
            let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.64.2/Projects/Includes/addToCart.php")! as URL)
            request.httpMethod = "POST"
            
            let postString = "a=\(userLabel.text!)&b=\(skuLabel.text!)&c=\(quantityText.text!)"
            
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
                "Added item to cart", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
