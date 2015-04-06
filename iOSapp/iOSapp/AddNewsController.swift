//
//  AddNewsController.swift
//  iOSapp
//
//  Created by Best Team on 2015-04-05.
//  Copyright (c) 2015 Team 404. All rights reserved.
//
import UIKit

class AddNewsController: UIViewController
{

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    @IBOutlet weak var titleField: UITextView!
    @IBOutlet weak var contentField: UITextView!
    
    @IBAction func postNews(sender: AnyObject) {
        //titleField is the title of the news
        //contentField is the news itself
        println(titleField.text)
        println(contentField.text)
        self.performSegueWithIdentifier("showCourseNews", sender: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("showCourseNews", sender: nil)
    }

}
