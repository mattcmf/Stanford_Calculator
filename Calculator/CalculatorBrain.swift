//
//  File.swift
//  Calculator
//
//  Created by Matthew Frampton on 09/01/2016.
//  Copyright © 2016 theswiftproject. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    //Printable is not inherited but is a protocol
    // this enum IMPLEMENTS whatever is in this printable
    private enum Op: CustomStringConvertible
    {
        //enum is like an array but it can only contain specific things, e.g. the binary or operand options below, to test try and enter a different option
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        //Computed variable
        var description: String {
            get{
                switch self{
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    //Array
    private var opStack = [Op]()

    
    //dictionary
    private var knownOps = [String: Op]()
    //or
    //var knownOps = Dictionary<String, Op>()
    
    //anytime someone says let brain = calc brain, this will be called with the corrosponding arguments, e.g. no arguments below
    init() {
        //not ideal we have the x twice
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×", *))
        //replace below
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") { $1 * $0 }
        knownOps["÷"] = Op.BinaryOperation("÷") { $1 * $0 }
        //knownOps["√"] = Op.BinaryOperation("√", sqrt)
    }
    
    //returns a named tuple (e.g. result is the name for the double variable)
    // Tuples can return more than 2 options
//    func evaluate(ops: [Op]) -> (result: Double?,remainingOps: [Op]) {
    //      need VAR OPS so we specify it as a new mutable array instead of referencing old array 
               // OR create local variable (remaining ops for example)
        private func evaluate(ops: [Op]) -> (result: Double?,remainingOps: [Op]) {

        if !ops.isEmpty {
            //can't do remove last on ops because it is immutable (read only)
            // why is it read only? unless its a class, the thing we pass is being copied. E.g. the Ops array is a copy o
            // ARRAYS AND DICTIONARIES ARE STRUCTS
            //      Classes can have inheritance
            //      Structs passed by value, classes passed by reference
        var remainingOps = ops
        let op = remainingOps.removeLast()
            switch op {
                //               case op.Operand(12)
            case .Operand(let operand):
                return (operand, remainingOps)
            /*for caes ike plus
            // _ underbar in swift = ignore, or I don't care about
            //if let used to check if not empty for optionals
            (48:30 into video)*/
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result{
                    return (operation(operand), operandEvaluation.remainingOps)
                }
                
            
            case .BinaryOperation(_ , let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return(operation(operand1,operand2),op2Evaluation.remainingOps)
                    }
                }
                break
            }
        }
        //if run out of operands or fall out of the stack, fail safely and return nil
        return (nil,ops)
            
    }
            
    
    //Needs to be optonal because need option to return nil (e.g. see ? at end of argument)
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    //recursion.
    
    
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        //Uses square brackers to look up item from dictionary
        
        //operation value returns OPTIONAL op instead of a regular op
            // this is because: we may  be looking something which doesn't exist in the array
        if let operation = knownOps[symbol] {
            opStack.append((operation))
        }
        return evaluate()
    }
    
    //private = private, but no key word = public by default
}