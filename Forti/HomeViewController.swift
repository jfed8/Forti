//
//  HomeViewController.swift
//  Forti
//
//  Created by J J Feddock on 12/3/15.
//  Copyright © 2015 Forti Athletics Inc. All rights reserved.
//

import UIKit
import Parse
import Bolts

class HomeViewController: UIViewController {
    

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
    
    var personalWorkouts = [PFObject]()
    
    func loadPersonalWorkouts() {
        
        var name = String()
        var distance = String()
        var date = String()
        
        let query = PFQuery(className:"PersonalWorkouts")
        query.whereKey("User", equalTo: (PFUser.currentUser()?["username"] as? String)!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) workouts.")
                // Do something with the found objects
                if let objects = objects {
                    
                    for object in objects {
                        print(object.objectId)
                        
                        name = object.valueForKey("Title") as! String
                        distance = object.valueForKey("Distance") as! String
                        date = object.valueForKey("Date") as! String
                        
                    
                        
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        print("Printing")
        
        let workoutTemp = Workout(name: name, date: date, distance: distance)
        
        workouts += [workoutTemp]
        

    }
    
   /*
        let query = PFQuery(className: "PersonalWorkouts")
        
        
        
        query.whereKey("User", equalTo: PFUser.currentUser()!)
        
                for object in objects
                {
                    
                    let workoutTemp = Workout(name: object.valueForKey("Title") as! String, date: object.valueForKey("Date") as! String, distance: object.valueForKey("Distance") as! String)
                    workouts += [workoutTemp]
                }
        
    }
    */

    
    func loadSampleWorkouts() {
        let workout1 = Workout(name: "Swim", date: "12.11.15", distance: "1500")
        
        let workout2 = Workout(name: "Bike", date: "12.10.15", distance: "78.2")
        
        let workout3 = Workout(name: "Run", date: "12.15.15", distance: "17.5")
        
        workouts += [workout1, workout2, workout3]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
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

    
    @IBAction func ReloadTable(sender: AnyObject) {
        tableMain!.reloadData()
        print("Done")
    }
    
    @IBOutlet weak var tableMain: UITableView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Show the current visitor's username
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.UsernameLabel.text = pUserName
        }
        
        
        
        loadPersonalWorkouts()
        
 //       loadSampleWorkouts()
        
        
     
    
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBOutlet weak var UsernameLabel: UILabel!
    
    
    
    
    @IBAction func logOutAction(sender: AnyObject){
        
        // Send a request to log out a user
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login - Main")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
