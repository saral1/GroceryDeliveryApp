//
//  ManItemGroceryViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-12.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

class ManItemGroceryViewController:UIViewController{
    
    @IBOutlet var skuLabel: UILabel!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var pPriceText: UITextField!
    @IBOutlet var sPriceText: UITextField!
    @IBOutlet var quantityText: UITextField!
    @IBOutlet var nameLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "BackToMan2", sender: self);
    }
    
    @IBAction func editItem(_ sender: Any) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.64.2/Projects/Includes/updateGrocery.php")! as URL)
        request.httpMethod = "POST"
        
        //a = sku
        //b = name
        //c = purchase price
        //d = sell price
        //e = quantity
        let postString = "a=\(skuLabel.text!)&b=\(nameText.text!)&c=\(pPriceText.text!)&d=\(sPriceText.text!)&e=\(quantityText.text!)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)");
                return
            }
            //print("response = \(response)")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("responseString = \(responseString)")
        }
        task.resume()
        //if you want a pop up
        let alertController = UIAlertController(title: "", message:
            "Item has been updated", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
        skuLabel.text = "";
        nameText.text = "";
        pPriceText.text = "";
        sPriceText.text = "";
        quantityText.text = "";
        
    }
    
    
    @IBAction func deleteItem(_ sender: Any) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.64.2/Projects/Includes/deleteGrocery.php")! as URL)
        request.httpMethod = "POST"
        
        //a = sku
        let postString = "a=\(skuLabel.text!)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)");
                return
            }
            //print("response = \(response)")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("responseString = \(responseString)")
        }
        task.resume()
        //if you want a pop up
        let alertController = UIAlertController(title: "", message:
            "Deleted Grocery Item", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        skuLabel.text = "";
        nameText.text = "";
        pPriceText.text = "";
        sPriceText.text = "";
        quantityText.text = "";
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        nameLabel.text = manUsername;
        skuLabel.text = manGroceries[manGroceryIndex].sku;
        nameText.text = manGroceries[manGroceryIndex].name;
        sPriceText.text = manGroceries[manGroceryIndex].sPrice;
        pPriceText.text = manGroceries[manGroceryIndex].pPrice;
        quantityText.text = manGroceries[manGroceryIndex].quantity
        ;
    }
}
