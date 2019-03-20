//
//  CustomerViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-09.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

class CustomerViewController:UIViewController{

    @IBOutlet var helloText: UILabel!
    //var passedText: String?
    var User: String?
    
    @IBAction func shopButton(_ sender: Any) {
        performSegue(withIdentifier: "GoToShopScreen", sender: self)
    }
    @IBAction func cartButton(_ sender: Any) {
        performSegue(withIdentifier: "GoToCartScreen", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        helloText.text = "Welcome " + custUsername!;
        User = custUsername;
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GoToShopScreen"){
            let shopVC = segue.destination as! ShopViewController
            shopVC.passedText = User!;
            shopVC.delegate = self;
        }
        if(segue.identifier == "GoToCartScreen"){
            let shopVC = segue.destination as! CartViewController
            shopVC.passedText = User!;
            shopVC.delegate = self;
        }

    }

    
    func changeLabelBack(labelText: String){
        User = labelText;
        helloText.text = "Welcome " + User!;
    }
 */
}
