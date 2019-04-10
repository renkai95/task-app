//
//  TaskListTableViewController.swift
//  assignment2
//
//  Created by rk on 10/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController ,UISearchResultsUpdating,AddTaskDelegate{
    let SECTION_TASK=0;
    let SECTION_COUNT=1;
    let CELL_TASK="titleCell"
    let CELL_COUNT="taskCount"
    var allTasks: [Task]=[]
    var filteredTasks: [Task]=[]
    weak var addTaskDelegate:AddTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDefaultTasks()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        filteredTasks=allTasks
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let searchController = UISearchController(searchResultsController: nil);
        searchController.searchResultsUpdater=self
        searchController.obscuresBackgroundDuringPresentation=false
        searchController.searchBar.placeholder="Search Tasks"
        navigationItem.searchController=searchController
        definesPresentationContext=true
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText=searchController.searchBar.text?.lowercased(),searchText.count>0{
            filteredTasks=allTasks.filter({(task:Task)->Bool in
                return task.name.lowercased().contains(searchText)
            })
        }
        else{
            filteredTasks=allTasks
        }
        tableView.reloadData();
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==SECTION_TASK{
            return filteredTasks.count
        }
        else{
            return 1
        }
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titleCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if indexPath.section==SECTION_TASK{
            let titleCell=tableView.dequeueReusableCell(withIdentifier: CELL_TASK, for: indexPath) as! TaskTableViewCell
            let task=filteredTasks[indexPath.row]
            titleCell.titleOutlet.text=task.name
            titleCell.descOutlet.text=task.desc
            
            titleCell.dueOutlet.text=date2String(task.duedate)
            return titleCell
            
        }
        // Configure the cell...
        let countCell=tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
        countCell.textLabel?.text="\(allTasks.count) tasks in the database"
        countCell.selectionStyle = .none
        return countCell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func date2String(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm" //yyyy
        return formatter.string(from: date)
    }
}
