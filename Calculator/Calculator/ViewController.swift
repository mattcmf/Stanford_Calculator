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
    
    var userIsInTheMiddleOfTyping = false
    
    //This reference is the "green arrow" in how the controller talks to the model
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + digit
        }
        else {
           display.text = digit
           userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation)
            {
                displayValue = result
            }
            else
            {
                //TODO: make less lame and set to nill etc instead
                displayValue = nil
            }
        }
    }
    
    @IBAction func setVariable(){
        brain.variableValues["M"] = displayValue
        display.text = ""
        print("Variable M = \(brain.variableValues["M"]!)")
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        
        if let result = displayValue{
            brain.pushOperand(result)
            displayValue = result
        }
        else{
            displayValue = nil
            //TODO: Set to nill
        }
    }
    
    var displayValue: Double? {
        get{
            if let dValue = display.text{
                if Int(dValue) == nil{
                    return brain.variableValues[dValue]!
                }
                else
                {
                    return NSNumberFormatter().numberFromString(dValue)!.doubleValue
                }
            }
            else{
                return nil
            }

        }
        set{
            if let dValue = newValue{
                display.text = "\(dValue)"
            }
            else
            {
                display.text = nil
            }

            userIsInTheMiddleOfTyping = false
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

