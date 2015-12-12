//
//  ViewController.swift
//  Tips
//
//  Created by Grace Egbo on 12/11/15.
//  Copyright © 2015 Grace Egbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet var FirstView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Tip Calculator"
        tipLabel.text = "0.00"
        totalLabel.text = "0.00"
        self.FirstView.alpha = 0
        UIView.animateWithDuration(1, animations: {
            // This causes first view to fade in 
            self.FirstView.alpha = 1
        })

    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("tipDefault") //gets current default value from settings
        tipControl.selectedSegmentIndex = intValue
        let billAmount = Double(billField.text!)
        if(billAmount == nil) //checks if bill amount field has a text in it, if it does it calls the method indicated to update the amount (if needed be)
        {
            
        }
        else
        {
          onEditingChanged(tipControl)
        }
        print("view will appear")
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("tipDefault") //gets current default value from settings
        tipControl.selectedSegmentIndex = intValue
        let billAmount = Double(billField.text!)
        if(billAmount == nil) //checks if bill amount field has a text in it, if it does it calls the method indicated to update the amount (if needed be)

        {
            
        }
        else
        {
            onEditingChanged(tipControl)
        }

        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("tipDefault") //gets current default value from settings
        tipControl.selectedSegmentIndex = intValue
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        super.viewDidDisappear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("tipDefault") //gets current default value from settings
        tipControl.selectedSegmentIndex = intValue
        print("view did disappear")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject)
    {
        let tipPercentages = [0.18,0.2,0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = Double(billField.text!)
        let tip = billAmount! * tipPercentage
        let total = billAmount! + tip
        
        
        tipLabel.text = String.localizedStringWithFormat("$%.2f", tip) //formats number to have 2 decimal points
        totalLabel.text = String.localizedStringWithFormat("$%.2f", total) //formats number to have 2 decimal points
    }

    @IBAction func onTap(sender: AnyObject)
    {
         view.endEditing(true)
    }

}

