//
//  ExchangeManager.swift
//  ConVert
//
//  Created by Andres Ruggiero on 8/4/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

import Foundation
import Parse
import Bolts

class ExchangeManager {
    
    var categoryArray = [Category]()
    var currencyArrayConfiguration = [String]()
    var readyToLoad : Bool = false
    
    init(){
        
    }
    
    // Check internet connection
    func checkConnection() -> (error: Bool, message: String){
        let reachability = Reachability.reachabilityForInternetConnection()
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                println("Reachable via WiFi")
            } else {
                println("Reachable via Cellular")
            }
            
            return (true,"Connection succesfull");
        } else {
            return (false,"Error: Check your connection")
        }
    }
    
    // Check if connection changed
    func reachabilityChanged(note: NSNotification) {
        
        println("Reachability changed")
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                println("Reachable via WiFi")
            } else {
                println("Reachable via Cellular")
            }
        } else {
            println("Not reachable")
        }
    }
    
    func queryAllObjectsFromParse() {
        
        let query = PFQuery(className: "Item")
        query.limit = 400
        query.findObjectsInBackgroundWithBlock {
            (objects, error) in
            if !(error != nil) {
                // Retrieved scores successfully
                println("Retrieved \(objects?.count) Items")
                self.loadCurrencyFromConfig(objects!)
            } else {
                var alert = UIAlertView(title: "Alert", message: "Error: Check network connection", delegate: self, cancelButtonTitle: "Ok")
                [alert .show()]
                self.readyToLoad = false;
            }
        }
    }

    // Load Currency Configuration from Parse
    func loadCurrencyFromConfig(array: [AnyObject]){
        println("Getting the latest config...");
        PFConfig.getConfigInBackgroundWithBlock {
            (var config: PFConfig?, error: NSError?) -> Void in
            if error == nil {
                println("Yay! Config was fetched from the server.")
            } else {
                println("Failed to fetch. Using Cached Config.")
                config = PFConfig.currentConfig()
            }
            
            var config: NSArray? = config?["currencyArray"] as? NSArray
            if let config = config {
                println("Config Found!")
                self.currencyArrayConfiguration = config as! [(String)]
                println(self.currencyArrayConfiguration)
                self.loadObjectsToClasses(array)
                self.readyToLoad = true;
            } else {
                println("Falling back to default message.")
            }
        };
    }
    
    func loadObjectsToClasses(array: [AnyObject]) {
        
        let newCategory = Category(name: "Currency")
        self.categoryArray.append(newCategory)
        
        for collection in self.currencyArrayConfiguration {
            println("The Categoy is \(collection)")
            
            // Creating new collection for each element of configuration element
            var newCollection = Collection(name: collection)
            
            for object in array {
                let newItem = Item(targetName: object["targetName"] as! String,
                    targetCurrency: object["targetCurrency"] as! String,
                    baseName: object["baseName"] as! String,
                    baseCurrency: object["baseCurrency"] as! String,
                    exchangeRate: object["exchangeRate"] as! String)
                newCollection.addItem(newItem)
            }
            newCategory.addCollection(newCollection)
        }
    }
    
}