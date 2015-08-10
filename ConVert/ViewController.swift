//
//  ViewController.swift
//  ConVert
//
//  Created by Andres Ruggiero on 8/4/15.
//  Copyright (c) 2015 Andres Ruggiero. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var manager = ExchangeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate connection object
        let connection = self.manager.checkConnection()
        
        // check for connection
        if (connection.error) {
            self.manager.queryAllObjectsFromParse()
        } else {
            println(connection.message)
        }
        
        // set up the refresh control
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.myTableView?.addSubview(refreshControl)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Refresh the table view
    func refresh(sender:AnyObject)
    {
        println("Hello World")
        
        // tell refresh control it can stop showing up now
        if self.refreshControl.refreshing
        {
            self.manager.queryAllObjectsFromParse()
            self.refreshControl.endRefreshing()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
        //cell.textLabel.text="row#\(indexPath.row)"
        cell.textLabel?.text = "HelloWorld!"
        //cell.detailTextLabel.text="subtitle#\(indexPath.row)"
        
        return cell
    }

}

