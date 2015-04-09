//
//  NewsViewController.swift
//  iOSapp
//
//  Created by Nav Bhatti on 2015-04-07.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import UIKit


class NewsViewController: UIViewController {
    
    @IBOutlet var titled: UILabel!
    @IBOutlet var text: UITextView!
    @IBOutlet var date: UILabel!
    @IBOutlet var author: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var newsItem = Data.sharedInstance.activeNews
        text.text = newsItem["content"].stringValue
        date.text = "Posted on " + DataSource.getNiceDate(newsItem["_id"].doubleValue as NSTimeInterval)
        author.text = "By " + newsItem["name"].stringValue
        titled.text = newsItem["title"].stringValue
    }
}