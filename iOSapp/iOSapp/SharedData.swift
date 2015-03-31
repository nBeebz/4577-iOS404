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

    var name: String = ""
    var age: Int = 0
}
