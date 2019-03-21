//
//  AddGroceryItem.swift
//  Fresh
//
//  Created by Sara on 2018-04-09.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

/*
protocol SendUsernameBackProtocol {
    func changeLabelBack(labelText: String)
}
 */

class AddGroceryItem:UIViewController{
    
    @IBOutlet var sku: UITextField!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var pPrice: UITextField!
    @IBOutlet var sPrice: UITextField!
    @IBOutlet var quantity: UITextField!
    
    @IBOutlet var username: UILabel!
    
    //var textPassed: String?
    var User: String?
    
    //var delegate:SendUsernameBackProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        username.text = manUsername;
        User = manUsername;
    }
    
    @IBAction func addGroceryButton(_ sender: Any) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.64.2/Projects/Includes/add.php")! as URL)
        request.httpMethod = "POST"
        
        let postString = "a=\(sku.text!)&b=\(nameText.text!)&c=\(pPrice.text!)&d=\(sPrice.text!)&e=\(quantity.text!)"
        
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
            "Item Successfully Added", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))

        self.present(alertController, animated: true, completion: nil)
        
        sku.text = ""
        nameText.text = ""
        pPrice.text = ""
        sPrice.text = ""
        quantity.text = ""
    }
    
    @IBAction func backButton(_ sender: Any) {
        //let inputText = changeLabelText.text!;
        //delegate?.changeLabelBack(labelText: User!);
        self.dismiss(animated: true, completion: nil);
    }
    
}
