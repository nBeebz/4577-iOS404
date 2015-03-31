//
//  LoginViewController.swift
//  Test
//
//  Created by Mae on 1/25/15.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import UIKit
//import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        var user = idTextField.text
        var password = pwdTextField.text
        if( countElements(user) == 0 || countElements(password) == 0 ){
            return;
        }
        var url = "https://api.mongolab.com/api/1/databases/sandbox/collections/students?q={\"_id\":\"" + user + "\"}&fo=true&apiKey=bup2ZBWGDC-IlRrpRsjTtJqiM_QKSmKa";
        url =  url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let req = request(.GET, url )
        
        req.responseJSON { (request, response, body, error) in
            // GET BODY HERE
            var user = JSON( body! )
            let pwd = user["password"].stringValue
            println(user["name"].stringValue)
            if( pwd == password ){
                if( user["type"].stringValue == "instructor" ){
                    self.performSegueWithIdentifier("iTerm", sender: nil);
                }
                else{
                    self.performSegueWithIdentifier("sTerm", sender: nil);
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func valid() -> Bool
    {
        return true;
    }
}

