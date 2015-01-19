//
//  SettingsViewController.swift
//  Tipping
//
//  Created by Jehan Tremback on 1/16/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

let colorSet = [
    ["primary": 0xFFFFFF, "secondary": 0xEFEFF4, "accent": 0x167EFB, "text": 0x000000],
    ["primary": 0x212F3D, "secondary": 0x374F70, "accent": 0x167EFB, "text": 0xFFFFFF],
    ["primary": 0xBC3B35, "secondary": 0xE34E47, "accent": 0x167EFB, "text": 0xFFFFFF],
    ["primary": 0x37AC65, "secondary": 0x41C977, "accent": 0x167EFB, "text": 0xFFFFFF],
    ["primary": 0xFBA63A, "secondary": 0xFDCB42, "accent": 0x167EFB, "text": 0x000000],
    ["primary": 0x3382B5, "secondary": 0x3F9AD6, "accent": 0x167EFB, "text": 0xFFFFFF]
]

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
    
    func setColor (index: Int) {
        println(index)
        defaults.setObject(colorSet[index], forKey: "themeColors")
        defaults.synchronize()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func color0Touched(sender: AnyObject) {
        setColor(0)
    }
    
    @IBAction func color1Touched(sender: AnyObject) {
        setColor(1)
    }
    
    @IBAction func color2Touched(sender: AnyObject) {
        setColor(2)
    }
    
    @IBAction func color3Touched(sender: AnyObject) {
        setColor(3)
    }
    
    @IBAction func color4Touched(sender: AnyObject) {
        setColor(4)
    }
    
    @IBAction func color5Touched(sender: AnyObject) {
        setColor(5)
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
