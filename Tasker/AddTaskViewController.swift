//
//  AddTaskViewController.swift
//  Tasker
//
//  Created by Louis Gornall on 17/05/2015.
//  Copyright (c) 2015 Louis Gornall. All rights reserved.
//

import UIKit
import CoreData



class AddTaskViewController: UIViewController {
    var managedObjectContext: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!

    var task : Tasks? = nil
    
    var todaysDate:NSDate{
        let date = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = cal!.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: date)
        let newDate = cal!.dateFromComponents(components)
        
        return newDate!
    }
    
// IBOutlets
    @IBOutlet var uitxtTitle: UITextField!
    
    @IBOutlet var uitxtDesc: UITextField!
  
    @IBOutlet var uiTaskDatePicker: UIDatePicker!
    
    @IBOutlet var uiDateLabel: UILabel!

    
// IBActions
    @IBAction func uiDatePickeValueChanged(sender: UIDatePicker) {
        updateDateLabel()
        
    }
    
    @IBAction func btnDone_tap(sender: UIBarButtonItem) {
        if (uitxtTitle.text == "") {
            
            uitxtTitle.text = "Enter a fucking Title"
            
        } else{
            if task != nil {
                editTask()
                
                switchToTaskListView()
            }else{
                createTask()
            
                switchToTaskListView()
            }
        }
        
    }
    
    @IBAction func uiDateLabel_tap(sender: UITapGestureRecognizer) {
        var x: Int = 0
        x = x + 1
        println("open date")
        var myView = self.view
    }
    
    @IBAction func uiBackground_tap(sender: UITapGestureRecognizer) {
        println("close date")
    }

//view funcs
    func updateDateLabel(){
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var dateValue = dateFormatter.stringFromDate(uiTaskDatePicker.date)
        
        uiDateLabel.text = dateValue
    }
    
    func switchToTaskListView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TaskListViewController") as!   UIViewController
        presentViewController(vc, animated: false, completion: nil)
    }
//task funcs
    func createTask(){
        var newTask: AnyObject = NSEntityDescription.entityForName("Tasks", inManagedObjectContext: managedObjectContext)!
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        
        let task = Tasks(entity: newTask as! NSEntityDescription, insertIntoManagedObjectContext: managedObjectContext)
        task.title = uitxtTitle.text
        task.desc = uitxtDesc.text
        
        println(uiTaskDatePicker.date)
        task.date = uiTaskDatePicker.date
        task.completed = 0
        managedObjectContext.save(nil)
    }
    
    func editTask() {
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        task?.title = uitxtTitle.text
        task?.desc = uitxtDesc.text
        task?.date = uiTaskDatePicker.date
        println(uiTaskDatePicker.date)
        managedObjectContext.save(nil)
    }
    
//over ridden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        if task != nil {
            uitxtTitle.text = task?.title
            uitxtDesc.text = task?.desc
            uiTaskDatePicker.date = task!.date
            updateDateLabel()
            
        }else {
            uiTaskDatePicker.date = todaysDate
            updateDateLabel()
            uitxtTitle.text = ""
            uitxtDesc.text = ""
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
