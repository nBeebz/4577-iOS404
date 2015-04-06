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

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoWebView: UIWebView!
    
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
                choiceLabel.text = 	"News and stuff"
                break
            // info view
            case 1 :
                self.newsView.hidden = true;
                self.infoView.hidden = false;
                //choiceLabel.text = "Info about the course"
                infoLabel.text = " Instructor: \n\t \(instrName) \n\t \(instrEmail) \n\t \(office) \n\n Office Hours: \(officeHrs) \n\n Evaluation Breakdown: \(breakdown)"
                break
            default :
                break
        }

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        courseNo = "COMP 4711"
        instrName = "Jim Parry"
        instrEmail = "jim_parry@bcit.ca"
        office = "SW2 124"
        officeHrs = "\n\t T: 1:30 - 2:30 \n\t Th: 1:30 - 3:30"
        breakdown = "\n\t Assignments 25% \n\t Labs 30% \n\t Midterm 20% \n\t Final Exam 25%"
        
        //Can change this to be way ever, creates button if true.
        if( isInstructor == 1) {
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
        
        // set the navigation bar title to show the course
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
