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
    @IBOutlet var history: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    var userHasEnteredDecimal = false
    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        history.text = history.text! + sender.currentTitle!

        
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + digit
        }
        else {
           display.text = digit
           userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        history.text = history.text! + operation
        
        if userIsInTheMiddleOfTyping {
            enter()
        }
        
        switch operation {
            //Basic example of closure
//            case "×": performOperation ({ (opt1: Double, opt2: Double) -> Double in
//            return opt1 * opt2
//            })
            //Shortened versions
            // Don't need type declaration as performOperation only accepts Doubles, so infers variable to be double
            // Don't need to name the variables op1 and opt 2, can just use dollar and swift will assign them accordingly.
            // If function is the LAST paramater, then it can be moved outside the paranthesis (which can then be removed as below) 
            case "×": performOperation {$0 * $1}
            case "÷": performOperation {$1 / $0}
            case "−": performOperation {$1 - $0}
            case "+": performOperation {$0 + $1}
            case "√": performOperation {sqrt($0)}
            case "sin": performOperation {sin($0)}
            case "cos": performOperation {cos($0)}
            case "π": performOperation (M_PI)
            default: break
        }
    }
    
//    Add a UILabel to your UI which shows a history of every operand and operation input by the user. Place it at an appropriate location in your UI.
    
    
 //   5. Add a C button that clears everything (your display, the new UILabel you added above, etc.). The Calculator should be in the same state as it is at application startup after you touch this new button.
    
    @IBAction func addDecimal(sender: UIButton) {
        let digit = sender.currentTitle!
        if !userHasEnteredDecimal {
            if (display.text == "0")
            {
                display.text = "0."
                userHasEnteredDecimal = true
                userIsInTheMiddleOfTyping = true
            }
            else{
            display.text = display.text! + digit
            }
        }
    }
    
    //The argument this takes is a FUNCTION (called operation) that takes 2 doubles and returns a double
    func performOperation(operation: (Double, Double) -> Double){
        displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
        enter()
    }
    
    private func performOperation(operation: Double -> Double){
        displayValue = operation(operandStack.removeLast())
        enter()
    }
    
    private func performOperation(let val: Double){
        displayValue = val
        enter()
    }
    
    var operandStack = Array<Double>()
    var inputsStack = Array<String>()

    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        userHasEnteredDecimal = true
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get{
            
            //Extra credit oooo
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
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

