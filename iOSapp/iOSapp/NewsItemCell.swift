//
//  NewsItemCell.swift
//  iOSapp
//
//  Created by Best Team on 2015-04-06.
//  Copyright (c) 2015 Team 404. All rights reserved.
//

import UIKit

class NewsItemCell: UITableViewCell {
    
    	
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Content: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
