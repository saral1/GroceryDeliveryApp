//
//  ManagerViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-09.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation
import UIKit

class ManagerViewController:UIViewController{
    
    @IBOutlet var welcomeText: UILabel!
    //var textPassed: String?
    //var User: String?

    @IBAction func EditGroceryButton(_ sender: Any) {
        performSegue(withIdentifier: "ManToGrocery", sender: self)
    }
    
    @IBAction func GoToViewStore(_ sender: Any) {
        performSegue(withIdentifier: "GoToAllStores", sender: self);
    }
    @IBAction func GoToDeliverySchedule(_ sender: Any) {
        performSegue(withIdentifier: "GoToDeliverySchedule", sender: self);
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad();
        welcomeText.text = "Welcome Manager " + manUsername!;
        //User = custUsername;
    }
    
    
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GoToAddGrocery"){
            let groceryVC = segue.destination as! AddGroceryItem
            groceryVC.textPassed = User!;
            groceryVC.delegate = self;
        }
    }
    
    func changeLabelBack(labelText: String) {
        User = labelText;
        welcomeText.text = "Welcome Manager " + User!;
    }
 */
}
