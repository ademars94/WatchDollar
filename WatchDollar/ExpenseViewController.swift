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
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let expenseCell = UINib(nibName: "ExpenseCell", bundle:nil)
        self.tableView.registerNib(expenseCell, forCellReuseIdentifier: "ExpenseCell")
        tableView.backgroundView = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshTable), forControlEvents: UIControlEvents.ValueChanged)
        self.getExpenses()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getExpenses() -> Void {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET, "https://peaceful-coast-28007.herokuapp.com/api/expense/index").validate().responseJSON { response in // 1
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                self.jsonArray = JSON as? NSMutableArray
                for item in self.jsonArray! {
                    let str = item["itemName"]!
                    print("Item: \(str!)")
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
            self.tableView.reloadData()
        }
    }
    
    func refreshTable() -> Void {
        self.getExpenses()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
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
            let expenseCategory:String? = expense.objectForKey("itemCategory") as? String
            let lowercaseCategory = expenseCategory?.lowercaseString
            cell.categoryLabel!.text = expenseCategory
            cell.categoryImage!.image = UIImage(named: lowercaseCategory!)
            
            let price = expense.objectForKey("price") as? String
            cell.priceLabel!.text = "$\(price!)"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ExpenseSegue", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func presentModal(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let modal = storyboard.instantiateViewControllerWithIdentifier(
            "ModalViewController") as! ModalViewController
        modal.modalPresentationStyle = .Custom
        modal.modalTransitionStyle   = .CrossDissolve
        self.navigationController!.presentViewController(modal, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ExpenseSegue" {
            let destination = segue.destinationViewController as? ExpenseDetailViewController,
            expense = self.jsonArray![(tableView.indexPathForSelectedRow!.row)]
            destination!.itemName = expense.objectForKey("itemName") as? String
        }
    }
}

