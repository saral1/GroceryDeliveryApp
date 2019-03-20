//
//  homeModel.swift
//  Fresh
//
//  Created by Sara on 2018-04-09.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit


protocol HomeModelDelegate: class {
    //If a view controller wants to conform to this protocol, then it must implement this function
    func getAllGrocery(grocery: [Grocery])
}

protocol HomeModelDelegate2: class {
    //If a view controller wants to conform to this protocol, then it must implement this function
    func getCart(grocery: [Grocery])
}

protocol HomeModelDelegate3: class {
    //If a view controller wants to conform to this protocol, then it must implement this function
    func getAllStore(store: [Store])
}

protocol HomeModelDelegate4: class {
    //If a view controller wants to conform to this protocol, then it must implement this function
    func getAllDelivery(delivery: [Delivery])
}

protocol HomeModelDelegate5: class {
    //If a view controller wants to conform to this protocol, then it must implement this function
    func getCustUsername(username: [Username])
}



class homeModel: NSObject{
    
    var delegate: HomeModelDelegate?
    var delegate2: HomeModelDelegate2?
    var delegate3: HomeModelDelegate3?
    var delegate4: HomeModelDelegate4?
    var delegate5: HomeModelDelegate5?
    //var data = Data()
    
    func getAllGrocery(){
        //Hit the web service URL
        let groceryUrl = "http://192.168.64.2/Projects/Includes/showGroceries.php"
        //Download the json data
        let url: URL = URL(string: groceryUrl)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data");
            }else {
                //succeeded
                //Parse it out into grocery structs
                print("Data downloaded");
                self.parseJSON(_data: data!)
            }
        }
        task.resume();
        
        //Notify the view controller and pass the data back
    }
    
    func getAllStore(){
        //Hit the web service URL
        let storeUrl = "http://192.168.64.2/Projects/Includes/showStore.php"
        //Download the json data
        let url: URL = URL(string: storeUrl)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data");
            }else {
                //succeeded
                //Parse it out into grocery structs
                print("Data downloaded");
                self.parseJSON3(_data: data!)
            }
        }
        task.resume();
        //Notify the view controller and pass the data back
    }
    
    func getCart(_user: String){
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.64.2/Projects/Includes/showCart.php")! as URL)
        request.httpMethod = "POST"
        var postString = "a=";
        postString.append(_user);
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task1 = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }else{
                //print("response = \(response)")
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                //print("responseString = \(responseString)")
                //print("Got Cart Data");
                self.parseJSON2(_data: data!)
            }
        }
        task1.resume();
        /*
        //MARK - Before
        //Hit the web service URL
        let groceryUrl = "http://192.168.64.2/Projects/Includes/showCart.php"
        //Download the json data
        let url: URL = URL(string: groceryUrl)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data");
            }else {
                //succeeded
                //Parse it out into grocery structs
                print("Data downloaded");
                self.parseJSON2(_data: data!)
            }
        }
        task.resume();
        //Notify the view controller and pass the data back
 */
    }
    
    func getAllDelivery(){
        let storeUrl = "http://192.168.64.2/Projects/Includes/showDelivery.php"
        //Download the json data
        let url: URL = URL(string: storeUrl)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data");
            }else {
                //succeeded
                //Parse it out into grocery structs
                print("Data downloaded");
                self.parseJSON4(_data: data!)
            }
        }
        task.resume();
        //Notify the view controller and pass the data back
    }
    func getCustUsername(){
        
        let storeUrl = "http://192.168.64.2/Projects/Includes/checkUser.php"
        //Download the json data
        let url: URL = URL(string: storeUrl)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed to download data");
            }else {
                //succeeded
                //Parse it out into grocery structs
                print("Data downloaded");
                self.parseJSON5(_data: data!)
                print(data);
            }
        }
        task.resume();
    }
    
    func parseJSON(_data: Data){
        var groceryArray = [Grocery]()
        do{
            let jsonArray = try JSONSerialization.jsonObject(with: _data, options: [] ) as! [Any]
            
            for jsonResult in jsonArray{
                let jsonDict = jsonResult as! [String:String]
                let groceryItem = Grocery(sku: jsonDict["sku"]!, name: jsonDict["name"]!, pPrice: jsonDict["purchaseprice"]!, sPrice: jsonDict["sellingprice"]!, quantity: jsonDict["quantity"]!)
                groceryArray.append(groceryItem)
            }
            //pass array back to delegate
            delegate?.getAllGrocery(grocery: groceryArray)
        }catch{
            print("Error parsing JSON data1");
        }
    }
    
    func parseJSON2(_data: Data){
        var groceryArray = [Grocery]()
        do{
            let jsonArray = try JSONSerialization.jsonObject(with: _data, options: [] ) as! [Any]
            
            for jsonResult in jsonArray{
                let jsonDict = jsonResult as! [String:String]
                let groceryItem = Grocery(sku: jsonDict["sku"]!, name: jsonDict["name"]!, pPrice: "", sPrice: jsonDict["sellingprice"]!, quantity: jsonDict["quantity"]!)
                groceryArray.append(groceryItem)
            }
            //pass array back to delegate
            delegate2?.getCart(grocery: groceryArray)
        }catch{
            print("Error parsing JSON data4");
        }
    }
    func parseJSON3(_data: Data){
        var storeArray = [Store]()
        do{
            let jsonArray = try JSONSerialization.jsonObject(with: _data, options: [] ) as! [Any]
            
            for jsonResult in jsonArray{
                let jsonDict = jsonResult as! [String:String]
                let storeItem = Store(storeid: jsonDict["storeid"]!, street: jsonDict["street"]!, city: jsonDict["city"]!, province: jsonDict["province"]!, postal: jsonDict["postalcode"]!,phone: jsonDict["phone"]!);
                storeArray.append(storeItem)
            }
            //pass array back to delegate
            delegate3?.getAllStore(store: storeArray)
        }catch{
            print("Error parsing JSON data3");
        }
    }
    
    func parseJSON4(_data: Data){
        var deliveryArray = [Delivery]()
        do{
            let jsonArray = try JSONSerialization.jsonObject(with: _data, options: [] ) as! [Any]
            print(jsonArray);
            
            for jsonResult in jsonArray{
                let jsonDict = jsonResult as! [String:String]
                let deliveryItem = Delivery(deliveryid: jsonDict["deliveryid"]!, planneddeliverydate: jsonDict["planneddeliverydate"]!, actualdeliverydate: "", delivered: jsonDict["delivered"]!, employeetodeliver: jsonDict["employeetodeliver"]!);
                deliveryArray.append(deliveryItem)
                print("HELLO FROM HERE");
            }
            //pass array back to delegate
            delegate4?.getAllDelivery(delivery: deliveryArray)
        }catch{
            print("Error parsing JSON data4");
        }
    }
    func parseJSON5(_data: Data){
        var userArray = [Username]()
        do{
            let jsonArray = try JSONSerialization.jsonObject(with: _data, options: [] ) as! [Any]
            print(jsonArray);
            
            for jsonResult in jsonArray{
                let jsonDict = jsonResult as! [String:String]
                let userItem = Username(name: jsonDict["username"]!, pass: jsonDict["password"]!);
                userArray.append(userItem)
                print("HELLO FROM HERE");
            }
            //pass array back to delegate
            delegate5?.getCustUsername(username: userArray);
        }catch{
            print("Error parsing JSON data2");
        }
    }
}
