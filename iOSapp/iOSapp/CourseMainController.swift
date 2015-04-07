//
//  CourseMainController.swift
//  iOSapp
//
//  Created by Mae on 2015-02-28.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import UIKit

struct NewsStruct{
    var index : Int
    
    var title : String
    var content : String
    var datetime : String
}

class CourseMainController: UIViewController, UITableViewDelegate, UITableViewDataSource
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
    
    @IBOutlet weak var Test: NewsItemCell!
    var newsArray : [NewsStruct] = []
    
    var courseNo: String!
    var courseName: String!
    var instrName: String!
    var instrEmail: String!
    var office: String!
    var officeHrs: String!
    var breakdown: String!
    var isInstructor = 1
    let items: [[String]] = [
    ["1"],
    ["2"]]
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
    
    @IBOutlet weak var tableView: UITableView!
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
        
        var newsArray : [NewsStruct] = []
        //The "data"
        var one : NewsStruct = NewsStruct(
            index        : 0,
            title        : "One",
            content      : "This is the first one",
            datetime     : "2015/5/5 at 12:12"
        )
        var two : NewsStruct = NewsStruct(
            index        : 1,
            title        : "Hello",
            content      : "Hello hello hello",
            datetime     : "2015/4/5 at 11:11"
        )
        //Appending it to the newsArray
        self.newsArray.append(one)
        self.newsArray.append(two)
    }

    @IBOutlet weak var TitleLab: UILabel!
    @IBOutlet weak var ContentLab: UILabel!
    @IBOutlet weak var DateLab: UILabel!
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func buttonAction(sender:UIButton!)
    {
        self.performSegueWithIdentifier("addView", sender: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 135
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int ) -> Int
    {
        return self.newsArray.count
    }
    
    @IBOutlet var Title: UILabel!
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : NewsItemCell!         = tableView.dequeueReusableCellWithIdentifier("NewsCell") as NewsItemCell
        //let object = objects[indexPath.row] as String
        cell.Title.text = self.newsArray[indexPath.row].title
        cell.Content.text = self.newsArray[indexPath.row].content
        cell.Date.text = self.newsArray[indexPath.row].datetime
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
}
