//
//  ModalViewController.swift
//  WatchDollar
//
//  Created by Alex DeMars on 8/25/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit
import Alamofire

class ModalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let categories:[String] = ["Food", "Entertainment", "Household", "Car", "Apollo", "Rent", "Misc"]
    
    var itemName:String?
    var itemCategory:String?
    var price:String?
    
    
    @IBOutlet weak var itemNameInput: UITextField!
    @IBOutlet weak var priceInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemCategory = self.categories[0]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.itemName = itemNameInput!.text
        self.price = priceInput!.text
        
        self.saveNewExpense()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveNewExpense() {
        let parameters: [String: AnyObject] = [
            "itemName"     : self.itemName!,
            "itemCategory" : self.itemCategory!,
            "price"        : self.price!
        ]
        
        Alamofire.request(.POST, "https://peaceful-coast-28007.herokuapp.com/api/expense", parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                print(response)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.itemCategory = self.categories[row]
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
