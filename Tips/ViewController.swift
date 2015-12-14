//
//  ViewController.swift
//  Tips
//
//  Created by Grace Egbo on 12/04/15.
//  Copyright © 2015 Grace Egbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    var billAmount: Double!
    
    @IBOutlet var FirstView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Tip Calculator"
        tipLabel.text = "0.00"
        totalLabel.text = "0.00"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("tipDefault") //gets current default value from settings
        tipControl.selectedSegmentIndex = intValue
        
        let colorValue = defaults.integerForKey("colorDefault")
        if(colorValue == 1)
        {
            self.view.backgroundColor = UIColor.lightGrayColor()
            billField.backgroundColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1)
        }
        else if(colorValue == 2)
        {
            self.view.backgroundColor = UIColor.purpleColor()
            billField.backgroundColor = UIColor(red: 0.91, green: 0.82, blue: 0.89, alpha: 1)
        }

        var initialTime = defaults.objectForKey("date")
        if(initialTime == nil)
        {
            defaults.setObject(NSDate(), forKey: "date")
            initialTime = defaults.objectForKey("date")
            billField.text! = String(defaults.doubleForKey("billAmount")) //set bill text field as value from user defaults
            print(initialTime)
        }
        else
        {
            let elaspedTime = NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("date") as! NSDate!)
            if (elaspedTime > 100.00) // checks if elasped time is more than 10 min (600 seconds)
            {
                defaults.setObject(nil, forKey: "date") //resets the time
                print(elaspedTime)
                print("Time has been reset")
            }
            else
            {
                billField.text! = String(defaults.doubleForKey("billAmount")) //set bill text field as value from user defaults
                print("Time has not been reset yet")
                print(elaspedTime)
            }

        }
        
        
        let billAmount = Double(billField.text!)
        if(billAmount != nil) //checks if bill amount field has a text in it, if it does it calls the method indicated to update the amount (if needed be)
        {
            onEditingChanged(tipControl)

        }

        self.FirstView.alpha = 0
        UIView.animateWithDuration(1, animations: {
            // This causes first view to fade in 
            self.FirstView.alpha = 1
        })
        print("View did load")
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("tipDefault") //gets current default value from settings
        tipControl.selectedSegmentIndex = intValue
        
        billField.becomeFirstResponder() // makes sure that the keyboard automatically pops up first
        let billAmount = Double(billField.text!)
        if(billAmount == nil) //checks if bill amount field has a text in it, if it does it calls the method indicated to update the amount (if needed be)
        {
            
        }
        else
        {
          onEditingChanged(tipControl)
        }
        
        let colorValue = defaults.integerForKey("colorDefault")
        if(colorValue == 1)
        {
            self.view.backgroundColor = UIColor.lightGrayColor()
            billField.backgroundColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1)
        }
        else if(colorValue == 2)
        {
            self.view.backgroundColor = UIColor.purpleColor()
            billField.backgroundColor = UIColor(red: 0.91, green: 0.82, blue: 0.89, alpha: 1)
        }
        else
        {
            self.view.backgroundColor = UIColor.whiteColor()
            billField.backgroundColor = UIColor.whiteColor()
        }
        
        billField.center.x -= view.bounds.width
        tipControl.center.x -= view.bounds.width
        tipLabel.center.x -= view.bounds.width
        totalLabel.center.x -= view.bounds.width

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
        
        let colorValue = defaults.integerForKey("colorDefault")
        if(colorValue == 1)
        {
            self.view.backgroundColor = UIColor.lightGrayColor()
            billField.backgroundColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1)
        }
        else if(colorValue == 2)
        {
            self.view.backgroundColor = UIColor.purpleColor()
            billField.backgroundColor = UIColor(red: 0.91, green: 0.82, blue: 0.89, alpha: 1)
        }
        else
        {
            self.view.backgroundColor = UIColor.whiteColor()
            billField.backgroundColor = UIColor.whiteColor()
        }

        UIView.animateWithDuration(0.5, animations: {
            self.billField.center.x += self.view.bounds.width
            self.tipControl.center.x += self.view.bounds.width
            self.tipLabel.center.x += self.view.bounds.width
            self.totalLabel.center.x += self.view.bounds.width
        })
        
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
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
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale() // This is the default
        
        if(billAmount != nil)
        {
            let tip = billAmount! * tipPercentage
            let total = billAmount! + tip
            tipLabel.text = formatter.stringFromNumber(tip) //formats number to have 2 decimal points
            totalLabel.text = formatter.stringFromNumber(total) //formats number to have 2 decimal points
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setDouble(billAmount!, forKey: "billAmount")
        }
        else
        {
            tipLabel.text = "0.00"
            totalLabel.text = "0.00"
        }
    }

    @IBAction func onTap(sender: AnyObject)
    {
         view.endEditing(true)
    }

}

