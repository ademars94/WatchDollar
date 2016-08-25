//
//  ExpenseViewController.swift
//  WatchDollar
//
//  Created by Alex DeMars on 8/22/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit
import Alamofire

class ExpenseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var jsonArray:NSMutableArray?
    var newArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "ExpenseCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "ExpenseCell")
        
        Alamofire.request(.GET, "http://192.168.0.17:1337/api/expense/index").validate().responseJSON { response in // 1
            print("Response Value: \(response.result.value!)")
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                self.jsonArray = JSON as? NSMutableArray
                for item in self.jsonArray! {
                    let str = item["itemName"]!
                    print("Item: \(str!)")
                }
            }
            
            self.tableView.reloadData()
        }
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.jsonArray != nil) {
            return self.jsonArray!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("1234")
        
        let cellIdentifier = "ExpenseCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExpenseCell
        
        if (self.jsonArray != nil) {
            let expense = self.jsonArray!.objectAtIndex(indexPath.row)
            print("Expense: \(expense)")
            cell.nameLabel!.text = expense.objectForKey("itemName") as? String
            cell.categoryLabel!.text = expense.objectForKey("itemCategory") as? String
            let price = expense.objectForKey("price") as? String
            cell.priceLabel!.text = "$\(price!)"
        }
        return cell
    }

}

