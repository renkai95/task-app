//
//  TaskViewController.swift
//  assignment2
//
//  Created by rk on 9/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController  ,UITextFieldDelegate {
    weak var addTaskDelegate:AddTaskDelegate?
    @IBOutlet weak var descOutlet: UITextField!
    @IBOutlet weak var dueOutlet: UIDatePicker!
    
  
    @IBOutlet weak var segOutlet: UISegmentedControl!
    @IBOutlet weak var titleOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Do any additional setup after loading the view.
        descOutlet.delegate = self
        
        descOutlet.delegate=self

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func createTask(_ sender: Any) {
        if titleOutlet.text != "" && descOutlet.text != ""
        {
            let title = titleOutlet.text!
            let desc = descOutlet.text!
            let due=dueOutlet.date
            let status = segOutlet.titleForSegment(at:segOutlet.selectedSegmentIndex)!
            
            let newTask = Task(name: title, description: desc,duedate:due,completed:status)
            

            return
        }
        
        var errorMsg = "Please ensure all fields are filled:\n"
        
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

}
