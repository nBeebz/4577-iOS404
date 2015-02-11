//
//  ViewController.swift
//  Test
//
//  Created by user27640 on 1/25/15.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        tempLabel.text = "loggin in..."
    }
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var choiceLabel: UILabel!
    
    @IBAction func segmentChanger(sender: UISegmentedControl) {
        switch 	segmentController.selectedSegmentIndex
        {
        case 0 :
            choiceLabel.text = 	"News and stuff"
            break
        case 1 :
            choiceLabel.text = "Info about the course"
            break
        default :
            break
        }
    }
}
