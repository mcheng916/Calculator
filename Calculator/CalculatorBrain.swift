//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Michael Cheng on 11/6/16.
//  Copyright © 2016 Michael Cheng. All rights reserved.
//

import Foundation

// $$$$$$$ add floating point number, a text field with history opration

class CalbulatorBrain {
    
    //    enum Optional<T> {
    //        case none
    //        case some (T)
    //    }
    
    private var accumulator = 0.0
    
    func setOperand (operand: Double ){
        accumulator = operand
    }
    
    private var operations: Dictionary <String, Operation> = [
        "π": Operation.Constant(Double.pi),
        "e": Operation.Constant(M_E),
        "±": Operation.UnaryOperation ({-$0}), //sqrt,
        "√": Operation.UnaryOperation (sqrt), //sqrt,
        "cos": Operation.UnaryOperation(cos),
        
        //since this infers to binary operation, which takes 2 doubles to produce a double
        //(op1: Double, op2: Double) -> Double {
        //return op1 * op2
        //}
        
        //        "×": Operation.BinaryOperation({ (op1: Double, op2: Double) -> Double in
        //            return op1 * op2
        //            }
        //        ),
        
        //        "×": Operation.BinaryOperation({ (op1, op2) in return op1 * op2}),
        
        //        "×": Operation.BinaryOperation({ ($0, $1) in return $0 * $1}),
        
        //        "×": Operation.BinaryOperation({return $0 * $1}),
        
        "×": Operation.BinaryOperation({$0 * $1}),
        "÷": Operation.BinaryOperation({$0 / $1}),
        "+": Operation.BinaryOperation({$0 + $1}),
        "-": Operation.BinaryOperation({$0 - $1}),
        "=": Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double)->Double)
        case Equals
        
    }
    
    func performOperation (symbol: String ){
        if let operation = operations[symbol]{
            switch operation {
            // pattern matching to get the associated value out
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator=function(accumulator)
            case .BinaryOperation(let function) :
                executePendingBinaryOperation()
                pending =  PendingBinaryOperationInfo (binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
                
            }
        }
        //        switch symbol {
        //        case "π": accumulator = M_PI
        //        case "√": accumulator = sqrt(accumulator)
        //        default: break
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
        
    }
    
    //want this to be nil until there is input
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo{
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
        
    }
    
    var result: Double{
        get{
            return accumulator
        }
    }
    
    
}
