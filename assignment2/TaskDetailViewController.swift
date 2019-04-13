//
//  TaskDetailViewController.swift
//  assignment2
//
//  Created by rk on 10/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    var passedValue:Tasks?
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var descOutlet: UILabel!
    @IBOutlet weak var dueOutlet: UILabel!
    @IBOutlet weak var statusOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if passedValue != nil{
            print("nope")
            titleOutlet.text=passedValue?.title
            descOutlet.text=passedValue?.desc
            dueOutlet.text=date2String((passedValue?.duedate!)!)
            statusOutlet.text=passedValue?.status
        }
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editTaskSegue"{
            let viewController = segue.destination as! TaskViewController
            viewController.passedValue=passedValue
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func date2String(_ date: NSDate) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm" //yyyy
        return formatter.string(from: date as Date)}
}
