//
//  ExpenseViewController.swift
//  WatchDollar
//
//  Created by Alex DeMars on 8/22/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit
import AFNetworking

class ExpenseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = AFHTTPRequestOperationManager()  
        manager.GET(
            "http://localhost:1337/api/",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                print("JSON: " + responseObject.description)
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError?) in
                print("Error: " + (error?.localizedDescription)!)
            }
        )
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        return cell
    }

}

