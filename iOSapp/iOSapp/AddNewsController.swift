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
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let month = components.month
        let year = components.year
        let day = components.day
        
        let dateString = "\(year)/\(month)/\(day) at \(hour):\(minutes) "
        //titleField is the title of the news
        //contentField is the news itself
        println(titleField.text)
        println(contentField.text)
        println(dateString)
        println(Data.sharedInstance.courseNo)
        println(Data.sharedInstance.username)
        
        var json:JSON = ["course":Data.sharedInstance.courseNo, "name":Data.sharedInstance.username,"title":titleField.text, "content":contentField.text, "date":dateString]
        request(.POST, "https://api.mongolab.com/api/1/databases/sandbox/collections/news?apiKey=bup2ZBWGDC-IlRrpRsjTtJqiM_QKSmKa", parameters: json, encoding: .JSON)
        
        self.performSegueWithIdentifier("showCourseNews", sender: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.performSegueWithIdentifier("showCourseNews", sender: nil)
    }

}
