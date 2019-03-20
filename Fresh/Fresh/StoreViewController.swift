//
//  StoreViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-12.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

class StoreViewController: UIViewController{
    
    @IBOutlet var username: UILabel!
    @IBOutlet var storeidText: UILabel!
    @IBOutlet var streetText: UITextField!
    @IBOutlet var cityText: UITextField!
    @IBOutlet var provText: UITextField!
    @IBOutlet var postalCode: UITextField!
    @IBOutlet var phoneText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        username.text = manUsername;
        storeidText.text = storeArray[storeArrayIndex].storeid;
        streetText.text = storeArray[storeArrayIndex].street;
        cityText.text = storeArray[storeArrayIndex].city;
        provText.text = storeArray[storeArrayIndex].province;
        postalCode.text = storeArray[storeArrayIndex].postalcode;
        phoneText.text = storeArray[storeArrayIndex].phone;
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "BackToAllStore", sender: self);
    }
    
    @IBAction func updateStore(_ sender: Any) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.64.2/Projects/Includes/updateStore.php")! as URL)
        request.httpMethod = "POST"
        
        //a = storeid
        //b = street
        //c = city
        //d = province
        //e = postal code
        //f = phone
        let postString = "a=\(storeidText.text!)&b=\(streetText.text!)&c=\(cityText.text!)&d=\(provText.text!)&e=\(postalCode.text!)&f=\(phoneText.text!)"
        
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
            "Store Information has been updated", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
        storeidText.text = "";
        streetText.text = "";
        cityText.text = "";
        provText.text = "";
        postalCode.text = "";
        phoneText.text = "";
        
    }
    
    @IBAction func deleteStore(_ sender: Any) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.64.2/Projects/Includes/deleteStore.php")! as URL)
        request.httpMethod = "POST"
        
        //a = storeid
        let postString = "a=\(storeidText.text!)"
        
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
            "Deleted Store", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
