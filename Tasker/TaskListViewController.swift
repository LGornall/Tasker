//
//  ViewController.swift
//  Tasker
//
//  Created by Louis Gornall on 17/05/2015.
//  Copyright (c) 2015 Louis Gornall. All rights reserved.
//

import UIKit
import CoreData

class TaskListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    //get fetched Results controller on init
    lazy var fetchedResultController: NSFetchedResultsController = {
       let _fetchedResultController = NSFetchedResultsController(fetchRequest: self.taskFetchRequest(), managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return _fetchedResultController
        
    }()
    //set a fetchRequest
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Tasks")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
        
    }
    
//Funcs for UITableView
    
    //set the section count in the Table
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultController.sections!.count
    }
    
    //Set the number of rows within a section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = fetchedResultController.sections![section] as! NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    //creating the cells with the TaskTableCell.xib
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {

        var custCell = tableView.dequeueReusableCellWithIdentifier("TaskTableCell") as! TaskCell
        
        let task = fetchedResultController.objectAtIndexPath(indexPath) as! Tasks
        custCell.loadWithTask(task)
        return custCell
    }
    
    // Tap on row and pass to mark as completed
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let task:Tasks = fetchedResultController.objectAtIndexPath(indexPath) as! Tasks
        //taskController.task = task
        if task.completed == 0{
            task.completed = 1
            println("task is completed")
        }else{
            task.completed = 0
            println("task is not completed")
        }
        self.managedObjectContext.save(nil)
        
    }
    
    //editing/deleting task
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

    }
    
// creating custom actions for uiTableViewCells
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
    
        
        var editAction: UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.performSegueWithIdentifier("edit", sender: cell)
            
        })
        editAction.backgroundColor = UIColor.blueColor()
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            let managedObject:NSManagedObject = self.fetchedResultController.objectAtIndexPath(indexPath) as! NSManagedObject
            self.managedObjectContext.deleteObject(managedObject)
            self.managedObjectContext.save(nil)
            
        })
    
        return [editAction, deleteAction]
    }
    //Did anything Change? Reload
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    //standard overridden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
        var nib = UINib(nibName: "TaskTableCell", bundle: nil)
        
        tableView.registerNib(nib, forCellReuseIdentifier: "TaskTableCell")
    
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "edit" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let taskController:AddTaskViewController = segue.destinationViewController as! AddTaskViewController
            let task:Tasks = fetchedResultController.objectAtIndexPath(indexPath!) as! Tasks
            taskController.task = task
        }
    }


}

