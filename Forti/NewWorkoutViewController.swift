//
//  NewWorkoutViewController.swift
//  Forti
//
//  Created by J J Feddock on 1/1/16.
//  Copyright © 2016 Forti Athletics Inc. All rights reserved.
//

import UIKit
import Parse
import Bolts

class NewWorkoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WorkoutTitle.becomeFirstResponder()
        
        DatePicker.addTarget(self, action: Selector("DatePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.DatePicker.hidden = true

        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        self.DatePicker.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func DatePickerChanged(DatePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let strDate = dateFormatter.stringFromDate(DatePicker.date)
        DateLabel.text = strDate
    }
    
    
    
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    @IBOutlet weak var WorkoutTitle: UITextField!
    
    @IBOutlet weak var WorkoutDistance: UITextField!
    
    @IBAction func AddWorkout(sender: AnyObject) {
        
        let pUserName = PFUser.currentUser()?["username"] as? String
        
        let workout = PFObject(className: "PersonalWorkouts")
        workout.setObject(pUserName!, forKey: "User")
        workout.setObject(WorkoutTitle.text!, forKey: "Title")
        workout.setObject(WorkoutDistance.text!, forKey: "Distance")
        workout.setObject(DateLabel.text!, forKey: "Date")
        workout.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                print("Workout Uploaded")
            } else {
                print("Error \(error)")
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Workouts")
            self.presentViewController(viewController, animated: true, completion: nil)
        })


        
    }
    
    @IBAction func displayDate(sender: AnyObject) {
        self.DatePicker.hidden = false
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
