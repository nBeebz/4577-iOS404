//
//  TermViewMasterController.swift
//  iOSapp
//
//  Created by Henry on 2015-02-03.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import UIKit
//import Alamofire

class TermViewMasterController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    let testVal = "COMP 4977"
    var classes:[JSON]! = []
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        //let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        
        //self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        DataSource.getCourses( self.setClasses )

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func setClasses(courses:[JSON])
    {
        // HENRY, UPDATE AND SHOW THE CLASS LIST HERE
        var indexPaths: [NSIndexPath] = []
        
        for var i=0; i<courses.count; ++i
        {
            self.classes.append(courses[i])
            indexPaths.append( NSIndexPath(forRow: i, inSection: 0) )
        }
        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
    }
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                Data.sharedInstance.activeCourse = self.classes[indexPath.row] as JSON
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        //let object = objects[indexPath.row] as String
        
        if (index < classes.count) {
            cell.textLabel!.text = classes[index]["_id"].stringValue
            cell.detailTextLabel?.text = classes[index++]["courseName"].string
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            classes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
}

