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

    // IBOutlets
    
    @IBOutlet var uitxtTitle: UITextField!
    
    @IBOutlet var uitxtDesc: UITextField!
    
    
    // IBActions
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
    

    
    
    @IBAction func uibtnTrash_tap(sender: UIBarButtonItem) {
        uitxtTitle.text = ""
        uitxtDesc.text = ""
        
    }
    
    //task funcs
    func createTask(){
        var newTask: AnyObject = NSEntityDescription.entityForName("Tasks", inManagedObjectContext: managedObjectContext)!
        
        let task = Tasks(entity: newTask as! NSEntityDescription, insertIntoManagedObjectContext: managedObjectContext)
        task.title = uitxtTitle.text
        task.desc = uitxtDesc.text
        
        managedObjectContext.save(nil)
    }
    
    func editTask() {
        task?.title = uitxtTitle.text
        task?.desc = uitxtDesc.text
        managedObjectContext.save(nil)
    }
    
        func switchToTaskListView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TaskListViewController") as!   UIViewController
        presentViewController(vc, animated: false, completion: nil)
    }
    
    //over ridden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        if task != nil {
            uitxtTitle.text = task?.title
            uitxtDesc.text = task?.desc
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
