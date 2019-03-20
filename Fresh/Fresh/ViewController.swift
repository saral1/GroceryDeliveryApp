//
//  ViewController.swift
//  Fresh
//
//  Created by Sara on 2018-04-09.
//  Copyright © 2018 Sara. All rights reserved.
//

import UIKit

var custUsername: String?
var manUsername: String?

var passWord: String?
//var queryResponse: String?

var custArray = [Username]();
var custArrayIndex = 0;

class ViewController: UIViewController, HomeModelDelegate5{

    @IBOutlet var usernameText: UITextField!
    @IBOutlet var passwordText: UITextField!
    var homeM = homeModel();
    
    var user = "";
    var pass = "";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        homeM.getCustUsername();
        homeM.delegate5 = self;
    }
    
    @IBAction func loginButton(_ sender: Any) {
        manUsername = usernameText.text;
        if(((usernameText.text!) == "manager1" && (passwordText.text!) == "abcde") ||
            ((usernameText.text!) == "manager2" && (passwordText.text!) == "abcde")){
            NSLog("Manager");
            //navigateToManagerInterface();
            performSegue(withIdentifier: "GoToManagerScreen", sender: self)
        }
        else{
            errorAlert();
        }
    }
    
    func getCustUsername(username: [Username]){
        custArray = username;
    }
    
    @IBAction func loginCustomerButton(_ sender: Any) {
        custUsername = usernameText.text;
        passWord = passwordText.text;
        if(((usernameText.text!) == "maria" && (passwordText.text!) == "abcde") ||
            ((usernameText.text!) == "sara1" && (passwordText.text!) == "a") ||
            ((usernameText.text!) == "juan1" && (passwordText.text!) == "asdfgh")){
            
            NSLog("Customer");
            //navigateToCustomerInterface();
            performSegue(withIdentifier: "GoToCustomerScreen", sender: self)
        }
        else{
            errorAlert();
        }
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GoToManagerScreen"){
            let managerVC = segue.destination as! ManagerViewController
            managerVC.textPassed = usernameText.text
        }
        if(segue.identifier == "GoToCustomerScreen"){
            let customerVC = segue.destination as! CustomerViewController
            customerVC.passedText = usernameText.text!
        }
    }
 */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    private func navigateToCustomerInterface(){
        let custStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let custNavigationVC = custStoryBoard.instantiateViewController(withIdentifier: "CustomerViewController") as?
            CustomerViewController else{
            return
        }
        present(custNavigationVC, animated:true, completion:nil)
    }
    private func navigateToManagerInterface(){
        let manStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let manNavigationVC = manStoryBoard.instantiateViewController(withIdentifier: "ManagerViewController") as? ManagerViewController else{
            return
        }
        present(manNavigationVC, animated:true, completion:nil)
    }
 */
    private func errorAlert(){
        let alert = UIAlertController(title: "Try Again", message: "User or manager does not exist or password is wrong", preferredStyle: .alert);
        let okay = UIAlertAction(title: "okay", style: .default)
        alert.addAction(okay);
        present(alert, animated: true, completion: nil)
    }
}
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //set so that when user presses return key when done typing, keyboard will be dismissed
        textField.resignFirstResponder();
        return true;
    }
}

