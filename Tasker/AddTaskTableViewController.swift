//
//  AddTaskTableViewController.swift
//  Tasker
//
//  Created by Louis Gornall on 08/06/2015.
//  Copyright (c) 2015 Louis Gornall. All rights reserved.
//

import UIKit

class AddTaskTableViewController: UITableViewController {

    @IBOutlet var uiTxtDesc: UITextView!

    @IBOutlet var uiTxtTitle: UITextField!
    
    let kPickerAnimationDuration = 0.40 // duration for the animation to slide the date picker into view
    let kDatePickerTag           = 99   // view tag identifiying the date picker view
    
    
    let kDateStartRow = 4
    
    let kDateCellID       = "dateCell";       // the cells with the start or end date
    let kDatePickerCellID = "datePickerCell"; // the cell containing the date picker
    
    // keep track which indexPath points to the cell with UIDatePicker
    var datePickerIndexPath: NSIndexPath?
    
    var pickerCellRowHeight: CGFloat = 216
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
   /* override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        var firstRow: NSIndexPath = NSIndexPath(forItem: 2, inSection: 0)
        
        tableView.selectRowAtIndexPath(firstRow, animated: false, scrollPosition: UITableViewScrollPosition.None)
        
        self.uiTxtTitle.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
