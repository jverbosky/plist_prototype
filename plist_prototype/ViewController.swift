//
//  ViewController.swift
//  plist_prototype
//
//  Created by something on 4/29/17.
//  Copyright © 2017 Pittsburgh TechHire. All rights reserved.
//

import UIKit
import SwiftyPlistManager

class ViewController: UIViewController {

    let dataPlistName = "Login"
    let usernameKey = "username"  // plist username key
    var usernameValue:String = ""  // plist username value to post to Sinatra app
    let pneStatusKey = "pneStatus"  // push notification enablement status key
    var pneStatusValue:String = ""  // push notification enablement status value to post to Sinatra app
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var statusUpdate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialize plist if present, otherwise copy over Login.plist file into app's Documents directory
        SwiftyPlistManager.shared.start(plistNames: [dataPlistName], logging: false)
        
        // Output plist value for username
        // readPlist(usernameKey)
        
    }

    // Function to determine push notification enablement status
    func checkPneStatus() {
        let notificationType = UIApplication.shared.currentUserNotificationSettings!.types
        if notificationType == [] {
            pneStatusValue = "0"
            print("notifications are NOT enabled")
        } else {
            pneStatusValue = "1"
            print("notifications are enabled")
        }
    }


    // Function to collect username from input field
    @IBAction func submitButton(_ sender: UIButton) {
        
        if inputField.text != "" {
            evaluatePlist(usernameKey, inputField.text!)
            statusUpdate.text = "Thank you \(inputField.text!)!"
            checkPneStatus()
            evaluatePlist(pneStatusKey, pneStatusValue)
        } else {
            statusUpdate.text = "Username not detected - please try again!"
        }
    }
    
    // Function to determine if plist is already populated
    func evaluatePlist(_ key:String, _ value:String) {
        
        // Run function to add key/value pairs if plist empty, otherwise run function to update values
        SwiftyPlistManager.shared.getValue(for: key, fromPlistWithName: dataPlistName) { (result, err) in
            if err != nil {
                populatePlist(key, value)
            } else {
                updatePlist(key, value)
            }
        }
    }
    
    // Function to populate empty plist file with specified key/value pair
    func populatePlist(_ key:String, _ value:String) {
        SwiftyPlistManager.shared.addNew(value, key: key, toPlistWithName: dataPlistName) { (err) in
            if err == nil {
                print("-------------> Value '\(value)' successfully added at Key '\(key)' into '\(dataPlistName).plist'")
            }
        }
    }
    
    // Function to update specified key/value pair in plist file
    func updatePlist(_ key:String, _ value:String) {
        SwiftyPlistManager.shared.save(value, forKey: key, toPlistWithName: dataPlistName) { (err) in
            if err == nil {
                print("------------------->  Value '\(value)' successfully saved at Key '\(key)' into '\(dataPlistName).plist'")
            }
        }
    }
    
    // Function to read key/value pairs out of plist
    func readPlist(_ key:Any) {
        
        // Retrieve value
        SwiftyPlistManager.shared.getValue(for: key as! String, fromPlistWithName: dataPlistName) { (result, err) in
            if err == nil {
                guard let result = result else {
                    print("-------------> The Value for Key '\(key)' does not exists.")
                    return
                }
                print("-------------> The Value for Key '\(key)' actually exists. It is: '\(result)'")
            } else {
                print("No key in there!")
            }
        }
    }

    
    
    
    

/* Backup for username-targeting functions */
//    // Function to collect username from input field
//    @IBAction func submitButton(_ sender: UIButton) {
//        
//        if inputField.text != "" {
//            evaluatePlist(inputField.text!)
//            statusUpdate.text = "Thank you \(inputField.text!)!"
//        } else {
//            statusUpdate.text = "Username not detected - please try again!"
//        }
//    }
//    
//    
//    // Function to determine if plist is already populated
//    func evaluatePlist(_ usernameValue:String) {
//        
//        // Run function to add key/value pairs if plist empty, otherwise run function to update values
//        SwiftyPlistManager.shared.getValue(for: usernameKey, fromPlistWithName: dataPlistName) { (result, err) in
//            if err != nil {
//                populatePlist(usernameKey, usernameValue)
//            } else {
//                updatePlist(usernameKey, usernameValue)
//            }
//        }
//    }
//    
//    // Function to populate empty plist file with specified key/value pair
//    func populatePlist(_ key:String, _ value:String) {
//        SwiftyPlistManager.shared.addNew(value, key: key, toPlistWithName: dataPlistName) { (err) in
//            if err == nil {
//                print("-------------> Value '\(value)' successfully added at Key '\(key)' into '\(dataPlistName).plist'")
//            }
//        }
//    }
//    
//    // Function to update specified key/value pair in plist file
//    func updatePlist(_ key:String, _ value:String) {
//        SwiftyPlistManager.shared.save(value, forKey: key, toPlistWithName: dataPlistName) { (err) in
//            if err == nil {
//                print("------------------->  Value '\(value)' successfully saved at Key '\(key)' into '\(dataPlistName).plist'")
//            }
//        }
//    }
//    
//    // Function to read key/value pairs out of plist
//    func readPlist(_ key:Any) {
//        
//        // Retrieve value
//        SwiftyPlistManager.shared.getValue(for: key as! String, fromPlistWithName: dataPlistName) { (result, err) in
//            if err == nil {
//                guard let result = result else {
//                    print("-------------> The Value for Key '\(key)' does not exists.")
//                    return
//                }
//                print("-------------> The Value for Key '\(key)' actually exists. It is: '\(result)'")
//            } else {
//                print("No key in there!")
//            }
//        }
//    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

