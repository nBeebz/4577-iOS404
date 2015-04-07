//
//  CourseMainController.swift
//  iOSapp
//
//  Created by Mae on 2015-02-28.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import UIKit



class CourseMainController: UIViewController
{
    @IBOutlet weak var choiceLabel: UILabel!
    
    @IBOutlet weak var segmentController: UISegmentedControl!

    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoWebView: UIWebView!

    // labels for infoView
    @IBOutlet weak var courseInfo: UILabel!
    @IBOutlet weak var instrInfo: UILabel!
    @IBOutlet weak var officeHrsInfo: UILabel!
    @IBOutlet weak var marksInfo: UILabel!

    var courseNo: String!
    var courseName: String!
    var instrName: String!
    var instrEmail: String!
    var office: String!
    var officeHrs: String!
    var breakdown: String!
    var isInstructor = 1
    
    @IBAction func segmentChanged(sender: UISegmentedControl)
    {
        switch 	segmentController.selectedSegmentIndex
        {
            // news view (default view)
            case 0 :
                self.newsView.hidden = false;
                self.infoView.hidden = true;
                break
            
            // info view
            case 1 :
                self.newsView.hidden = true;
                self.infoView.hidden = false;
                
                courseInfo.text = "\(courseName)"
                instrInfo.text = " \(instrName) \n \(instrEmail) \n \(office)"
                officeHrsInfo.text = officeHrs
                marksInfo.text = breakdown
                break
            
            // default
            default :
                break
        }

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // NAV:  here's the hardcoded data that needs to be pulled from DB
        courseNo = "COMP 4711"
        courseName = "Internet Software Development"
        instrName = "Jim Parry"
        instrEmail = "jim_parry@bcit.ca"
        office = "SW2 124"
        officeHrs = " T: 1:30 - 2:30 \n Th: 1:30 - 3:30"
        breakdown = " Assignments 25% \n Labs 30% \n Midterm 20% \n Final Exam 25%"
        
        // creates the + button if true.
        if( isInstructor == 1)
        {
            let image = UIImage(named: "add139.png") as UIImage?
            let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
            button.frame = CGRectMake(283, 92, 25, 25)
            button.setImage(image, forState: .Normal)
            button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            
            self.view.addSubview(button)
        }
        
        let localFile = NSBundle.mainBundle().URLForResource("info", withExtension: "html")
        let myRequest = NSURLRequest(URL: localFile!);
        infoWebView.loadRequest(myRequest)
        
        // set the navigation bar title to show the course number
        self.navigationItem.title = Data.sharedInstance.courseNo
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func buttonAction(sender:UIButton!)
    {
        self.performSegueWithIdentifier("addView", sender: nil)
    }

}
