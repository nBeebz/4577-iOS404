//
//  CourseMainController.swift
//  iOSapp
//
//  Created by Mae on 2015-02-28.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import UIKit


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
    var newsArray : [JSON] = []
    
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
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var course = Data.sharedInstance.activeCourse
        
        instrInfo.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: "emailPopup:")
        instrInfo.addGestureRecognizer(tapGesture)
        
        // get data
        courseNo = course["_id"].stringValue
        courseName = course["courseName"].stringValue
        instrName = course["instructorName"].stringValue
        instrEmail = course["instructorEmail"].stringValue
        office = course["officeLocation"].stringValue
        
        var dict = course["officeHours"].dictionaryValue
        
        officeHrs = ""
        var counter1 = 0
        for (key, value) in dict
        {
            officeHrs = officeHrs + key + ": " + value.stringValue + "\n"
            counter1++
        }

        breakdown = ""
        var counter2 = 0
        dict = course["markBreakdown"].dictionaryValue
        for (key, value) in dict
        {
            breakdown = breakdown + key + ": " + value.stringValue + "\n"
            counter2++
        }

        // add extra newlines if not enough lines of data
        // otherwise text is centered vertically in the label
        // and the extra white space makes it look unpolished
        while counter1 < 3
        {
            officeHrs = officeHrs + "\n"
            counter1++
        }
        while counter2 < 6
        {
            breakdown = breakdown + "\n"
            counter2++
        }

        // creates the + button if true.
        if( Data.sharedInstance.activeUser["instructor"].boolValue )
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
        self.navigationItem.title = Data.sharedInstance.activeCourse["_id"].stringValue
        
        DataSource.getNews( self.setNews )
    }

    func setNews(news:[JSON])
    {
        var indexPaths: [NSIndexPath] = []
        
        for var i=0; i<news.count; ++i
        {
            self.newsArray.append(news[i])
            indexPaths.append( NSIndexPath(forRow: i, inSection: 0) )
        }
        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
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
        var cell : NewsItemCell! = tableView.dequeueReusableCellWithIdentifier("NewsCell") as NewsItemCell
        var newsItem = self.newsArray[indexPath.row]
        //let object = objects[indexPath.row] as String
        cell.Title.text = newsItem["title"].stringValue
        cell.Content.text = newsItem["name"].stringValue
        cell.Date.text = DataSource.getNiceDate( newsItem["_id"].doubleValue as NSTimeInterval )
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showNews" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                Data.sharedInstance.activeNews = self.newsArray[indexPath.row] as JSON
            }
        }
    }
    
    func emailPopup(sender:UITapGestureRecognizer){
        let url = NSURL(string: "mailto:\(instrEmail!)")
        UIApplication.sharedApplication().openURL(url!)
        println("Email going to: \(instrEmail)")
    }
    
}
