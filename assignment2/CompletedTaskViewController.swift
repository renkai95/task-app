//
//  CompletedTaskViewController.swift
//  assignment2
//
//  Created by rk on 10/4/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit

class CompletedTaskViewController: UITableViewController ,UISearchResultsUpdating,DatabaseListener{
    var value:Tasks!
    let SECTION_TASK=0;
    let SECTION_COUNT=1;
    let CELL_TASK="completedCell"
    let CELL_COUNT="taskCount"
    var allTasks: [Tasks]=[]
    var filteredTasks: [Tasks]=[]
    var listenerType=ListenerType.tasks
    weak var addTaskDelegate:AddTaskDelegate?
    weak var databaseController: DatabaseProtocol?
    //@IBOutlet weak var searchTask: UISearchBar!
    override func viewDidLoad() {
    super.viewDidLoad()
    //createDefaultTasks()
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    filteredTasks=allTasks
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    databaseController=appDelegate.databaseController
    let searchController = UISearchController(searchResultsController: nil);
    searchController.searchResultsUpdater=self
    searchController.obscuresBackgroundDuringPresentation=false
    searchController.searchBar.placeholder="Search Tasks"
    navigationItem.searchController=searchController
    definesPresentationContext=true
    }
    func updateSearchResults(for searchController: UISearchController) {
    if let searchText=searchController.searchBar.text?.lowercased(),searchText.count>0{
    filteredTasks=allTasks.filter({(task:Tasks)->Bool in
    return (task.title!.lowercased().contains(searchText))
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
    
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //let titleCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    if indexPath.section==SECTION_TASK{
    let titleCell=tableView.dequeueReusableCell(withIdentifier: CELL_TASK, for: indexPath) as! CompletedTableViewCell
    let task=filteredTasks[indexPath.row]
    titleCell.titleOutlet.text=task.title
    titleCell.descOutlet.text=task.desc
    
    titleCell.dueOutlet.text=date2String(task.duedate!)
    return titleCell
    
    }
    // Configure the cell...
    else if indexPath.section==SECTION_COUNT{
    let countCell=tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
    countCell.textLabel?.text="\(allTasks.count) tasks in the database"
    countCell.selectionStyle = .none
    return countCell
    }
    return tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section==SECTION_COUNT{
    tableView.deselectRow(at: indexPath, animated: false)
    return
    }
    // Return false if you do not want the specified item to be editable.
    
    let task=filteredTasks[indexPath.row]
        print(task.title!)
    value=task
    performSegue(withIdentifier: "taskDetailSegue", sender: self)
    return
    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    databaseController?.addListener(listener: self)
    
    }
    
    func onTaskListChange(change:DatabaseChange,tasks:[Tasks]){
    allTasks=tasks.filter({(task:Tasks)->Bool in
    return (task.status=="Completed")
    })
    updateSearchResults(for: navigationItem.searchController!)
    }
    override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    databaseController?.removeListener(listener: self)
    }
    
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    
    if (segue.identifier == "taskDetailSegue") {
    // initialize new view controller and cast it as your view controller
    let viewController = segue.destination as! TaskDetailViewController
    // your new view controller should have property that will store passed value
    print(value.title!)
    viewController.passedValue = value
    }
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    }
    /*
     func addTask(newTask: Tasks) -> Bool {
     allTasks.append(newTask)
     filteredTasks.append(newTask)
     tableView.beginUpdates()
     tableView.insertRows(at: [IndexPath(row:filteredTasks.count-1,section:0)], with: .automatic)
     tableView.endUpdates()
     tableView.reloadSections([SECTION_COUNT], with: .automatic)
     return true
     }
     */
    
    func displayMessage(title:String,message:String){
    let alertController=UIAlertController(title:title,message:message,preferredStyle: UIAlertController.Style.alert)
    alertController.addAction(UIAlertAction(title:"Dismiss",style:UIAlertAction.Style.default,handler:nil))
    self.present(alertController,animated:true,completion: nil)
    }
    
    func date2String(_ date: NSDate) -> String {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy HH:mm" //yyyy
    return formatter.string(from: date as Date)
    }
    func string2Date(_ dateStr:String)->NSDate{
    let dateFmt = DateFormatter()
    dateFmt.dateFormat =  "yyyy-MM-dd"
    let date = dateFmt.date(from: dateStr)
    
    return date! as NSDate
    
    }
    }



