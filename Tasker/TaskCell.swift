//
//  TaskCell.swift
//  Tasker
//
//  Created by Louis Gornall on 20/05/2015.
//  Copyright (c) 2015 Louis Gornall. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet var title: UILabel!

    @IBOutlet var desc: UILabel!
    

    @IBOutlet var dateLabel: UILabel!
    

    
    func loadWithTask(task: Tasks){
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        
        title.text = task.title
        desc.text = task.desc
        var dateString = dateFormatter.stringFromDate(task.date)
        dateLabel.text = dateString
        
        //println("\(task.date) and \(todaysDate)")
        //println(task.date.timeIntervalSince1970, todaysDate.timeIntervalSince1970)
        
        
        if task.completed == 1{
            title.textColor = UIColor.greenColor()
            desc.textColor = UIColor.greenColor()
            dateLabel.textColor = UIColor.greenColor()
        } else if task.completed == 0 && task.date.timeIntervalSince1970 < todaysDate.timeIntervalSince1970 {
            title.textColor = UIColor.redColor()
            desc.textColor = UIColor.redColor()
            dateLabel.textColor = UIColor.redColor()
        } else if task.completed == 0 && task.date.timeIntervalSince1970 == todaysDate.timeIntervalSince1970 {
            title.textColor = UIColor.orangeColor()
            desc.textColor = UIColor.orangeColor()
            dateLabel.textColor = UIColor.orangeColor()
        } else {
            title.textColor = UIColor.blackColor()
            desc.textColor = UIColor.blackColor()
            dateLabel.textColor = UIColor.blackColor()
        }
    }
    
    var todaysDate:NSDate{
        let date = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = cal!.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: date)
        let newDate = cal!.dateFromComponents(components)
        
        return newDate!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
