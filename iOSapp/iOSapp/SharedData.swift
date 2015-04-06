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

    var courseNo: String = ""
    var user: User?
    var username: String = ""
}

class DataSource {
    var BASE_URL = "https://api.mongolab.com/api/1/databases/sandbox/collections/"
    
    
    class func getCourses( handler: ([String])->() ){
        //println("HELLO")
        var url = "https://api.mongolab.com/api/1/databases/sandbox/collections/courses?apiKey=bup2ZBWGDC-IlRrpRsjTtJqiM_QKSmKa"
        var req = request(.GET, url )
        var c:[String] = []
        req.responseJSON { (request, response, body, error) in
            // GET BODY HERE
            var array = JSON( body! ).arrayValue
            let arr = JSON( body! ).arrayValue
            
            for obj in array{
                c.append( obj["_id"].stringValue )
            }
            
            handler( c )
        }
    }
}

struct User {
    var id: String
    var name: String
    var courses:[String: Course]?
    var type: String
}

struct Course {
    var id: String
    var description: String
    var news: [NewsItem]
    var info: [String: String]
}

struct NewsItem {
    var date: NSDate
    var author: String
    var text: String
}

