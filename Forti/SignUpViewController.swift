//
//  SignUpViewController.swift
//  Forti
//
//  Created by J J Feddock on 12/3/15.
//  Copyright © 2015 Forti Athletics Inc. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SignUpViewController: UIViewController {

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
    
    
    @IBOutlet weak var NewUsernameField: UITextField!
    @IBOutlet weak var NewPasswordField: UITextField!
    @IBOutlet weak var NewPassword2Field: UITextField!
    
    @IBOutlet weak var NewEmailField: UITextField!
    @IBOutlet weak var NewEmail2Field: UITextField!
    
    
    
    @IBAction func signUpAction(sender: AnyObject) {
        
        let username = self.NewUsernameField.text
        let password = self.NewPasswordField.text
        let password2 = self.NewPassword2Field.text
        let email = self.NewEmailField.text
        let confirmEmail = self.NewEmail2Field.text
        let finalEmail = confirmEmail!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Validate the text fields
        if username?.characters.count < 3 {
            let alert = UIAlertController(title: "Invalid", message:"Username must be longer than 3 characters", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
        } else if password?.characters.count < 6 {
            let alert = UIAlertController(title: "Invalid", message:"Password must be longer than 6 characters", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
            
        } else if password != password2 {
            let alert = UIAlertController(title: "Invalid", message:"Passwords do not match", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        
        
        } else if email?.characters.count < 8 {
            let alert = UIAlertController(title: "Invalid", message:"Please enter a valid email address", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
        
        
        
        } else if self.NewEmailField.text != self.NewEmail2Field.text {
            let alert = UIAlertController(title: "Invalid", message:"Emails do not match", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
            
        } else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = finalEmail
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                if ((error) != nil) {
                    let alert = UIAlertController(title: "Nice Try", message:"User not found", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}
                    
                } else {
                    
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Workouts")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
            })
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        if (textField == self.NewEmail2Field) {
            textField.resignFirstResponder()
            
            // call the login logic
            signUpAction(self)
        } else if (textField == self.NewUsernameField) {
            self.NewPasswordField.becomeFirstResponder()
        } else if (textField == self.NewPasswordField) {
            self.NewPassword2Field.becomeFirstResponder()
        }else if (textField == self.NewPassword2Field) {
            self.NewEmailField.becomeFirstResponder()
        }else if (textField == self.NewEmailField) {
            self.NewEmail2Field.becomeFirstResponder()
        }
        
        return true
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
