//
//  SettingsTableViewController.swift
//  Tasker
//
//  Created by Louis Gornall on 06/06/2015.
//  Copyright (c) 2015 Louis Gornall. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
