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
    @IBOutlet weak var billExplanationLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipExplanationLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalExplanationLabel: UILabel!
    @IBOutlet weak var numberGuestsLabel: UILabel!
    @IBOutlet weak var numberGuests: UIStepper!
    @IBOutlet weak var numberGuestsBG: UIView!
    @IBOutlet weak var splitExplanationLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!

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
        if let themeColors: AnyObject = defaults.objectForKey("themeColors") {
            colors = themeColors as [String: Int]
        }
        
        view.backgroundColor = UIColor(hex: colors["primary"]!)
        tipControl.tintColor = UIColor(hex: colors["accent"]!)
        billField.backgroundColor = UIColor(hex: colors["secondary"]!)
        billField.textColor = UIColor(hex: colors["text"]!)
        billExplanationLabel.textColor = UIColor(hex: colors["text"]!)
        numberGuestsBG.backgroundColor = UIColor(hex: colors["secondary"]!)
        tipLabel.textColor = UIColor(hex: colors["text"]!)
        tipExplanationLabel.textColor = UIColor(hex: colors["text"]!)
        totalExplanationLabel.textColor = UIColor(hex: colors["text"]!)
        totalLabel.textColor = UIColor(hex: colors["text"]!)
        
    }
//    "zh_Hans_CN"
//    "de_DE"
//    "en_US"
//    "en_GB"
//    "ru_RU"
//    "ko_KR"
    func recalc () {
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "ko_KR")
        let tipPercentage = Double(tipPercentages[tipControl.selectedSegmentIndex])
        
        let billAmount = (billField.text as NSString).doubleValue
        let tip = billAmount * (tipPercentage / 100.00)
        let total = billAmount + tip
        let split = total / numberGuests.value
        
        numberGuestsLabel.text = "\(Int(numberGuests.value))"
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
        splitLabel.text = formatter.stringFromNumber(split)
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
            splitExplanationLabel.text = "Each Guest Pays"
        } else {
            splitExplanationLabel.text = "You Pay"
        }
        
        recalc()
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

