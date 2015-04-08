//
//  LoginViewController.swift
//  Test
//
//  Created by Mae on 1/25/15.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonPressed(sender: AnyObject)
    {
        var user = idTextField.text
        var password = pwdTextField.text
        
        // no userID or password provided
        if( countElements(user) == 0 || countElements(password) == 0 )
        {
            tempLabel.text = "Please type in your ID and password."
            return;
        }
        DataSource.verifyUser( user, password: password, handler: self.loginStatus )
    }
    
    func loginStatus(success: Bool){
        if(success){
            self.performSegueWithIdentifier("sTerm", sender: nil);
        }else{
            self.tempLabel.text = "Invalid ID or password.  Try again."
        }
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        idTextField.delegate = self
        pwdTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func valid() -> Bool
    {
        return true;
    }
    
    // dismiss keyboard when the RETURN key is pressed
    func textFieldShouldReturn (pwdTextField: UITextField!) -> Bool
    {
        self.view.endEditing(true)
        return false
    }
}

