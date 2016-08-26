//
//  ModalViewController.swift
//  WatchDollar
//
//  Created by Alex DeMars on 8/25/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let categories:[String] = ["Food", "Entertainment", "Household", "Car", "Apollo", "Rent", "Misc"]
    
   
    
    @IBOutlet weak var itemNameInput: UITextField!
    @IBOutlet weak var priceInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
