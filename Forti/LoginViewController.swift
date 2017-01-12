//
//  LoginViewController.swift
//  Forti
//
//  Created by J J Feddock on 12/3/15.
//  Copyright © 2015 Forti Athletics Inc. All rights reserved.
//

import UIKit
import Parse
import Bolts

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBAction func FBLogin(sender: AnyObject) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        if (textField == self.PasswordField) {
            textField.resignFirstResponder()
            
            // call the login logic
          loginAction(self)
        } else if (textField == self.UsernameField) {
            self.PasswordField.becomeFirstResponder()
        }
        
        return true
    }
    
    
    
    @IBAction func loginAction(sender: AnyObject) {
        let username = self.UsernameField.text
        let password = self.PasswordField.text
        
        // Validate the text fields
        if username?.characters.count < 3 {
            let alert = UIAlertController(title: "Invalid", message:"Username must be longer than 3 characters", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
        } else if password?.characters.count < 6 {
            let alert = UIAlertController(title: "Invalid", message:"Password must be longer than 6 characters", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
        } else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send a request to login
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                if ((user) != nil) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Workouts")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                    
                    
                } else {
                    let alert = UIAlertController(title: "Nice Try", message:"User not found", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}
                }
            })
        }

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
