//
//  DeliveryDetailViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-12.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

class DeliveryDetailViewController:UIViewController{
    
    @IBOutlet var deliveryid: UILabel!
    @IBOutlet var expectedDeliveryDate: UILabel!
    @IBOutlet var delivered: UITextField!
    @IBOutlet var employee: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        deliveryid.text = manDelivery[manDeliveryIndex].deliveryid;
        expectedDeliveryDate.text = manDelivery[manDeliveryIndex].planneddeliverydate;
        delivered.text = manDelivery[manDeliveryIndex].delivered;
        employee.text = manDelivery[manDeliveryIndex].employeetodeliver;
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "BackToMan6", sender: self)
    }
    
    @IBAction func updateDelivery(_ sender: Any) {
        if(delivered.text != "n" && delivered.text !=
            "y"){
            let alertController = UIAlertController(title: "Error", message:
                "Delivered must be n for no or y for yes", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        //update delivery
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.64.2/Projects/Includes/updateDelivery.php")! as URL)
        request.httpMethod = "POST"
        
        //a = deliveryid
        //b = delivered
        //c = employee
        let postString = "a=\(deliveryid.text!)&b=\(delivered.text!)&c=\(employee.text!)";
        
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
            "Delivery schedule has been updated", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
        deliveryid.text = "";
        expectedDeliveryDate.text = "";
        delivered.text = "";
        employee.text = "";
    }
    
}
