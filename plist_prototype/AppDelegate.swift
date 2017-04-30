//
//  AppDelegate.swift
//  plist_prototype
//
//  Created by something on 4/29/17.
//  Copyright © 2017 Pittsburgh TechHire. All rights reserved.
//

import UIKit
import SwiftyPlistManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let dataPlistName = "Login"
    let usernameKey = "username"  // plist username key
    let passwordKey = "password"  // plist password key

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Initialize plist if present, otherwise copy over plist into app's Documents directory
        SwiftyPlistManager.shared.start(plistNames: [dataPlistName], logging: false)
        
        // Populate/update plist with username and password
        evaluatePlist("jverbosky@iphone.com", "password456")
        
        // Collect plist values for username and password
        readPlist(usernameKey)
        readPlist(passwordKey)
        
        return true
    }
    
    // Function to determine if plist is already populated
    func evaluatePlist(_ usernameValue:String, _ passwordValue:String) {
      
        // Run function to add key/value pairs if plist empty, otherwise run function to update values
        SwiftyPlistManager.shared.getValue(for: usernameKey, fromPlistWithName: dataPlistName) { (result, err) in
            if err != nil {
                populatePlist(usernameKey, usernameValue)
                populatePlist(passwordKey, passwordValue)
            } else {
                updatePlist(usernameKey, usernameValue)
                updatePlist(passwordKey, passwordValue)
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
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

