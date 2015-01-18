//
//  SettingsViewController.swift
//  Tipping
//
//  Created by Jehan Tremback on 1/16/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipField: UITextField!
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    var tipPercentages = [18, 20, 22]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let percentages: AnyObject = defaults.objectForKey("tipPercentages") {
            tipPercentages = percentages as [Int]
        }
        
        for (index, tipPercentage) in enumerate(tipPercentages) {
            tipControl.setTitle("\(tipPercentage)%", forSegmentAtIndex: index)
        }
        
        if let selected: Int = defaults.integerForKey("selectedPercentage") as Int? {
            tipControl.selectedSegmentIndex = selected
        } else {
            tipControl.selectedSegmentIndex = 1
        }
        
        tipField.text = "\(tipPercentages[tipControl.selectedSegmentIndex])"
    }

    @IBAction func tipFieldChanged(sender: AnyObject) {
        let tipPercentage = (tipField.text as NSString).integerValue
        
        tipPercentages[tipControl.selectedSegmentIndex] = tipPercentage
        
        defaults.setObject(tipPercentages, forKey: "tipPercentages")
        defaults.synchronize()
        
        tipControl.setTitle("\(tipPercentage)%", forSegmentAtIndex: tipControl.selectedSegmentIndex)
    }
    
    @IBAction func tipControlChanged(sender: AnyObject) {
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]

        tipField.text = "\(tipPercentage)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
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
