//
//  CourseMainController.swift
//  iOSapp
//
//  Created by Mae on 2015-02-28.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import UIKit

class CourseMainController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var segmentController: UISegmentedControl!

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoWebView: UIWebView!
    @IBOutlet weak var tableView: UITableView!
    
    var courseNo: String!
    var courseName: String!
    var instrName: String!
    var instrEmail: String!
    var office: String!
    var officeHrs: String!
    var breakdown: String!
    
    let daysOfWeek = ["M", "T", "W", "Th", "F"]
    var courseInfo = [String: [String: String]]()
    var instrInfo = [String: String]()
    var hoursInfo = [String: String]()
    var breakdownInfo = [String: String]()
    
    
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

                instrInfo["Instructor"] = instrName
                instrInfo["Email"] = instrEmail
                instrInfo["Office"] = office
                hoursInfo["Office Hours"] = officeHrs
                breakdownInfo["Evaluation Breakdown"] = breakdown

                courseInfo["Instructor"] = instrInfo
                courseInfo["Office Hours"] = hoursInfo
                courseInfo["Evaluation Breakdown"] = breakdownInfo
                
                
                infoLabel.text = " Instructor: \n\t \(instrName) \n\t \(instrEmail) \n\t \(office) \n\n Office Hours: \(officeHrs) \n\n Evaluation Breakdown: \(breakdown)"
                break
            default :
                break
        }

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        courseNo = "COMP 4711"
        
        switch (courseNo) {
            case "BLAW 3600":
                instrName = "Catherine Ryan"
                instrEmail = "cryan3@my.bcit.ca"
                office = "SE6 327"
                officeHrs = "\n\t TBD"
                breakdown = "\n\t Participation 10% \n\t Case Presentations 20% \n\t Midterm 35% \n\t Final Exam 35%"

            case "COMP 4560":
                instrName = "Brenda Fine"
                instrEmail = "bfine@my.bcit.ca"
                office = "SW2 219"
                officeHrs = "\n\t M: 10:30 - 11:30, 2:30 - 3:30 \n\t T: 2:30 - 3:30 \n\t F: 10:30 - 12:30"
                breakdown = "\n\t Weekly Quizzes 20% \n\t Assignments 15% \n\t Midterm 25% \n\t Final Exam 40%"
            case "COMP 4711":
                instrName = "Jim Parry"
                instrEmail = "jim_parry@bcit.ca"
                office = "SW2 124"
                officeHrs = "\n\t T: 1:30 - 2:30 \n\t Th: 1:30 - 3:30"
                breakdown = "\n\t Labs 30% \n\t Assignments 25% \n\t Midterm 20% \n\t Final Exam 25%"
            case "COMP 4735":
                instrName = "Mirela Gutica"
                instrEmail = "mgutica1@my.bcit.ca"
                office = "SW2 127"
                officeHrs = "\n\t W: 10:30 - 1:30 \n\t Th: 3:30 - 5:30"
                breakdown = "\n\t Lab Activities 10% \n\t Weekly Quizzes 15% \n\t Assignments 20% \n\t Midterm 20% \n\t Final Exam 35%"
            case "COMP 4976":
                instrName = "Medhat Elmasry"
                instrEmail = "melmasry1@my.bcit.ca"
                office = "SW2 121"
                officeHrs = "\n\t by appointment"
                breakdown = "\n\t Labs 20% \n\t Quizzes 10% \n\t Assignments 25% \n\t  Group Project 30% \n\t Midterm 15% \n\t Final Exam 15%"
            case "COMP 4977":
                instrName = "D'Arcy Smith"
                instrEmail = "ds.bcit@gmail.com"
                office = "SW2 301"
                officeHrs = "\n\t TBD"
                breakdown = "\n\t Assignments 30% \n\t Group Project 30% \n\t Midterm 10% \n\t Final Exam 30%"
        default:
            break;
        }
        
        let localFile = NSBundle.mainBundle().URLForResource("info", withExtension: "html")
        let myRequest = NSURLRequest(URL: localFile!);
        infoWebView.loadRequest(myRequest)
        
        
        // set the navigation bar title to show the course
        self.navigationItem.title = courseNo
        
        println(courseNo)
        println(instrName)
        println(instrEmail)
        println(officeHrs)
        println(breakdown)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTAbleView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // create an array listing the keys for the courseInfo dictionary
        // will need to use the array to get the correct number of rows in each section
        let keyArray = Array(courseInfo.keys)
        
        return courseInfo[keyArray[section]]!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = indexPath.row                         // get the array index from the index path
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as UITableViewCell
        
        //let keys = courseInfo.keys
        //let myRowKey = courseInfo.keyList[row]              // the dictionary key
        //let myRowData = courseInfo.attribute[myRowKey]      // the dictionary value
        //cell.detailTextLabel!.text! = myRowData
        
        
        return cell
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
