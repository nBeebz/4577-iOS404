//
//  SharedData.swift
//  iOSapp
//
//  Created by Team5 on 2015-03-31.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import Foundation

class Data {
    class var sharedInstance: Data {
        struct Static {
            static var instance: Data?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Data()
        }
        
        return Static.instance!
    }
    
    
    /* USAGE */
    
    /* Add variables and their datatype below and initialize them.
       To access the variables from any view controller, simply create a variable at the root of that viewcontroller
       like so: let SharedData = Data.sharedInstance, then simply access and manipulate these variables in the class
       using self.SharedData.{variable_here}, such as self.SharedData.name = "Bob" or println(self.SharedData.name)
    */

    var activeCourse: JSON = []
    var activeUser: JSON = []
    var activeNews: JSON = []
}

class DataSource {
    
    class func getCourses( handler: ([JSON])->() ){
        //println("HELLO")
        
        var array = Data.sharedInstance.activeUser["courses"].arrayValue
        var courseList = "["
        for( var i = 0; i<array.count; i++){
            courseList += "\"" + array[i].stringValue + "\""
            if( i<array.count-1 ){
                courseList += ","
            }
        }
        courseList += "]"

        var url = "https://api.mongolab.com/api/1/databases/sandbox/collections/courses?q={\"_id\":{$in:"
            + courseList
            + "}}&apiKey=bup2ZBWGDC-IlRrpRsjTtJqiM_QKSmKa"
        url =  url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        var req = request(.GET, url )
        var c:[JSON] = []
        req.responseJSON { (request, response, body, error) in
            // GET BODY HERE
            var array = JSON( body! ).arrayValue
            
            for obj in array{
                c.append( obj )
            }
            
            handler( c )
        }
    }
    
    class func getNews( handler: ([JSON])->() ){
        var url = "https://api.mongolab.com/api/1/databases/sandbox/collections/news?q={\"course\":\""
            + Data.sharedInstance.activeCourse["_id"].stringValue
            + "\"}&apiKey=bup2ZBWGDC-IlRrpRsjTtJqiM_QKSmKa"
        url =  url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        var req = request(.GET, url )
        var c:[JSON] = []
        req.responseJSON { (request, response, body, error) in
            // GET BODY HERE
            var array = JSON( body! ).arrayValue
            
            for obj in array{
                c.append( obj )
            }
            
            handler( c )
        }
    }
    
    class func getNiceDate( timestamp: NSTimeInterval ) -> String {
        var formatter = NSDateFormatter()
        formatter.timeStyle = NSDateFormatterStyle.MediumStyle
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        var locale = NSLocale(localeIdentifier: "en_US")
        var date = NSDate(timeIntervalSince1970: timestamp)
        return formatter.stringFromDate(date)
    }
}

