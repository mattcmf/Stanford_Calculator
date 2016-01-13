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
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            enter()
        }
        switch operation {
            case "×": performOperation {$0 * $1}
            case "÷": performOperation {$1 / $0}
            case "−": performOperation {$1 - $0}
            case "+": performOperation {$0 + $1}
            //case "√": performOperation {sqrt($0)}
            default: break
        }
        //test
    }
    
    func multiply(opt1: Double, opt2: Double) -> Double{
        return opt1 * opt2
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
        enter()
    }
    
    private func performOperation(operation: Double -> Double){
        displayValue = operation(operandStack.removeLast())
        enter()
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
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

