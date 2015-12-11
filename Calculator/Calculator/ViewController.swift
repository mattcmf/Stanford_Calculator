//
//  ViewController.swift
//  Calculator
//
//  Created by Matthew Frampton on 23/11/2015.
//  Copyright © 2015 theswiftproject. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var display: UILabel!
    var userIsInTheMiddleOfTyping: Bool = false
    var containsDecimalPlace: Bool = false
    var Action: String!
    var initialValue: Int = 0
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            if (digit == ".")
            {
                if (containsDecimalPlace == false)
                {
                    display.text = display.text! + digit
                }
            }
            else
            {
                display.text = display.text! + digit
            }
            
        }
        else
        {
           display.text = digit
           userIsInTheMiddleOfTyping = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

