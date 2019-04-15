//
//  TaskViewController.swift
//  assignment2
//
//  Created by rk on 9/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController  ,UITextFieldDelegate {
    //weak var addTaskDelegate:AddTaskDelegate?
    var passedValue:Tasks?
    weak var databaseController:DatabaseProtocol?
    @IBOutlet weak var descOutlet: UITextField!
    @IBOutlet weak var dueOutlet: UIDatePicker!
    
  
    @IBOutlet weak var segOutlet: UISegmentedControl!
    @IBOutlet weak var titleOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        databaseController=appDelegate.databaseController
        //Do any additional setup after loading the view.
        //print(passedValue)
        if (passedValue != nil) {
            //print("init")
            
            titleOutlet.text=passedValue?.title
            titleOutlet.isUserInteractionEnabled = false
            descOutlet.text=passedValue?.desc
            dueOutlet.date=passedValue?.duedate! as! Date
        
        }

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func createTask(_ sender: Any) {
        if titleOutlet.text != "" && descOutlet.text != "" && passedValue==nil
        {
            let title = titleOutlet.text!
            let desc = descOutlet.text!
            let due=dueOutlet.date
            let status = segOutlet.titleForSegment(at:segOutlet.selectedSegmentIndex)!
    
            let _ = databaseController!.addTask(title: title, desc: desc,status: status, duedate: due as NSDate)
            //let _ = taskDelegate!.addTask(newTask:)
            displayMessage(title:"Success!",message:"Task inserted successfully")
            navigationController?.popViewController(animated: true)
            return
        }
        else if titleOutlet.text != "" && descOutlet.text != "" && passedValue != nil && dueOutlet.date>Date(){
            let title = titleOutlet.text!
            let desc = descOutlet.text!
            let due=dueOutlet.date
            let status = segOutlet.titleForSegment(at:segOutlet.selectedSegmentIndex)!
            
            let _ = databaseController!.editTask(task: Task(name: title, description: desc,duedate: due as NSDate, completed: status))
            //let _ = taskDelegate!.addTask(newTask:)
            displayMessage(title:"Success!",message:"Task updated successfully")
            navigationController?.popViewController(animated: true)
            return
            
        }
        var errorMsg = "Please ensure all fields are entered correctly:\n"
        if !(dueOutlet.date > Date()) {
            errorMsg+="- Your new task is long overdue\n"
        }
        if titleOutlet.text == "" {
            errorMsg += "- Must provide a title\n"
        }
        if descOutlet.text == "" {
            errorMsg += "- Must provide a description\n"
        }
  
        
        displayMessage(title: "Not all fields filled", message: errorMsg)
    }

    
    func displayMessage(title: String, message: String) {
        // Setup an alert to show user details about the Person
        // UIAlertController manages an alert instance
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleOutlet.resignFirstResponder()
        descOutlet.resignFirstResponder()
    }
}
