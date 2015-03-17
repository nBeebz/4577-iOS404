//
//  TermViewMasterController.swift
//  iOSapp
//
//  Created by Henry on 2015-02-03.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import UIKit

class TermViewMasterController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var objects = NSMutableArray()
    let testVal = "COMP 4711"
    var classes:[String]!
    var index = 0
    var selectedCourse: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        classes = self.getClasses()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        
        objects.insertObject(testVal, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
    }

    func getClasses() -> [String]
    {
        //LOOK HERE NAV
        var c:[String] = ["COMP 4977", "COMP 4976", "COMP 4735", "COMP 4711", "COMP 4560", "BLAW 3600"]
        return c
    }
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //if segue.identifier == "showDetail"
        //{
            if let indexPath = self.tableView.indexPathForSelectedRow()
            {
                let object = objects[indexPath.row] as String
                let navVC = segue.destinationViewController as UINavigationController
                let detailVC = navVC.topViewController as DetailViewController
                //let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                //let courseInfoVC = navVC.viewControllers.first as CourseMainController
                
                //courseInfoVC.courseNo = object
                //println("77 object: \(object)")
                //println("78 courseInfoVC.courseNo: \(courseInfoVC.courseNo)")

                detailVC.detailItem = object
                detailVC.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                detailVC.navigationItem.leftItemsSupplementBackButton = true
                
                
            }
        //println("\n line 85:  did not go into if statement?")
        //}

    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let object = objects[indexPath.row] as String
        
        if (index < classes.count) {
            
            //selectedCourse = classes[index]
            //println("108 selectedCourse: \(selectedCourse)")
            //println("index: \(index) \n")
            cell.textLabel!.text = classes[index++]
            //println(cell.textLabel!.text)
            
        }
            
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
}

