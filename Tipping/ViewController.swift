//
//  ViewController.swift
//  Tipping
//
//  Created by Jehan Tremback on 1/15/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var numberGuestsLabel: UILabel!
    @IBOutlet weak var numberGuests: UIStepper!
    @IBOutlet weak var totalExplanationLabel: UILabel!

    let defaults = NSUserDefaults.standardUserDefaults()
    let formatter = NSNumberFormatter()
    
    var tipPercentages = [18, 20, 22]
    var colors = ["primary": 0xFFFFFF, "secondary": 0xEFEFF4, "accent": 0x167EFB, "text": 0x000000]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let selected: Int = defaults.integerForKey("selectedPercentage") as Int? {
            tipControl.selectedSegmentIndex = selected
        } else {
            tipControl.selectedSegmentIndex = 1
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if let percentages: AnyObject = defaults.objectForKey("tipPercentages") {
            tipPercentages = percentages as [Int]
        }
        
        for (index, tipPercentage) in enumerate(tipPercentages) {
            tipControl.setTitle("\(tipPercentage)%", forSegmentAtIndex: index)
        }
        
        recalc()
        recolor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recolor () {
        if let cl: AnyObject = defaults.objectForKey("themeColors") {
            colors = cl as [String: Int]
        }
        
        tipControl.tintColor = UIColor(hex: colors["accent"]!)
        billField.backgroundColor = UIColor(hex: colors["primary"]!)
    }
    
    func recalc () {
        formatter.numberStyle = .CurrencyStyle
        
        let tipPercentage = Double(tipPercentages[tipControl.selectedSegmentIndex])
        
        let billAmount = (billField.text as NSString).doubleValue
        let tip = billAmount * (tipPercentage / 100.00)
        let total = (billAmount + tip) / numberGuests.value
        
        numberGuestsLabel.text = "\(Int(numberGuests.value))"
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
    }
    
    @IBAction func tipControlChanged(sender: AnyObject) {
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "selectedPercentage")
        defaults.synchronize()
        
        recalc()
    }
    
    @IBAction func billAmountChanged(sender: AnyObject) {
        recalc()
    }
    
    @IBAction func numberGuestsChanged(sender: AnyObject) {
        if numberGuests.value > 1 {
            totalExplanationLabel.text = "Each Guest Pays"
        } else {
            totalExplanationLabel.text = "You Pay"
        }
        
        recalc()
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

