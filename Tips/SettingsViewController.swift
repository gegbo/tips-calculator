//
//  SettingsViewController.swift
//  Tips
//
//  Created by Grace Egbo on 12/04/15.
//  Copyright © 2015 Grace Egbo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var defaultTip: UISegmentedControl!
    @IBOutlet weak var defaultColor: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Default Tip Settings"
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("tipDefault")
        let colorValue = defaults.integerForKey("colorDefault")
        
        defaultTip.selectedSegmentIndex = intValue
        defaultColor.selectedSegmentIndex = colorValue
        
        if(colorValue == 1)
        {
            self.view.backgroundColor = UIColor.lightGrayColor()
        }
        else if(colorValue == 2)
        {
            self.view.backgroundColor = UIColor.purpleColor()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tipDefault(sender: AnyObject) //synchronizes current value as default
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTip.selectedSegmentIndex, forKey: "tipDefault")
        defaults.synchronize()
    }

    @IBAction func colorDefault(sender: AnyObject)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultColor.selectedSegmentIndex, forKey: "colorDefault")
        defaults.synchronize()
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
