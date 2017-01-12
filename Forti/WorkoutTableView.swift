//
//  WorkoutTableView.swift
//  Forti
//
//  Created by J J Feddock on 1/1/16.
//  Copyright © 2016 Forti Athletics Inc. All rights reserved.
//

import UIKit
import Parse
import Bolts

class WorkoutTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    
    
    struct Workout{
        var name: String
        var date: String
        var distance: String
        init(name: String, date: String, distance: String){
            self.name = name
            self.distance = distance
            self.date = date
        }
        
    };
    
    var workouts = [Workout]()
    
    
    func loadSampleWorkouts() {
        let workout1 = Workout(name: "Swim", date: "12.11.15", distance: "1500")
        
        let workout2 = Workout(name: "Bike", date: "12.10.15", distance: "78.2")
        
        let workout3 = Workout(name: "Run", date: "12.15.15", distance: "17.5")
        
        workouts += [workout1, workout2, workout3]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workouts.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        
        let cellIdentifier = "WorkoutCell"
        
        func registerClass(cellClass: AnyClass?,
            forCellReuseIdentifier identifier: String){
                
        }
        
        registerClass(WorkoutTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutCell") as! WorkoutTableViewCell
        
        
        let workout = workouts[indexPath.row]
        
        cell.WorkoutName.text = workout.name
        cell.WorkoutDate.text = workout.date
        cell.WorkoutDistance.text = workout.distance
        
        
        // Configure the cell...
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}


