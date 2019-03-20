//
//  AddStore.swift
//  Fresh
//
//  Created by Sara on 2018-04-12.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

class AddStore:UIViewController{
    
    @IBOutlet var username: UILabel!
    @IBOutlet var streetText: UITextField!
    @IBOutlet var cityText: UITextField!
    @IBOutlet var provText: UITextField!
    @IBOutlet var postalText: UITextField!
    @IBOutlet var phoneText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        username.text = manUsername;
    }
    @IBAction func addStoreButton(_ sender: Any) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.64.2/Projects/Includes/addStore.php")! as URL)
        request.httpMethod = "POST"
        
        //a = street
        //b = city
        //c = prov
        //d = postal
        //e = phone
        let postString = "a=\(streetText.text!)&b=\(cityText.text!)&c=\(provText.text!)&d=\(postalText.text!)&e=\(phoneText.text!)"
        
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
            "Store Successfully Added", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
        streetText.text = ""
        cityText.text = ""
        provText.text = ""
        postalText.text = ""
        phoneText.text = ""
    }
    
    @IBAction func backButton(_ sender: Any) {
        //let inputText = changeLabelText.text!;
        //delegate?.changeLabelBack(labelText: User!);
        self.dismiss(animated: true, completion: nil);
    }
    
}
