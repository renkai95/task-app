//
//  TaskViewController.swift
//  assignment2
//
//  Created by rk on 9/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    @IBOutlet weak var descOutlet: UITextField!

    @IBOutlet weak var dueOutlet: UITextField!
    @IBOutlet weak var segOutlet: UISegmentedControl!
    @IBOutlet weak var titleOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func createTask(_ sender: Any) {
        if titleOutlet.text != "" && descOutlet.text != "" && dueOutlet.text!==""
        {
            let title = titleOutlet.text!
            let desc = descOutlet.text!
            let due=dueOutlet.text!
            let newTask = Task(name: title, description: desc,duedate:due,)
            
            let _ = superHeroDelegate!.addSuperHero(newHero: hero)
            navigationController?.popViewController(animated: true)
            return
        }
        
        var errorMsg = "Please ensure all fields are filled:\n"
        
        if nameTextField.text == "" {
            errorMsg += "- Must provide a name\n"
        }
        if abilitiesTextField.text == "" {
            errorMsg += "- Must provide abilities"
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
