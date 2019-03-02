//
//  ViewController.swift
//  Calculator
//
//  Created by Michael Cheng on 11/3/16.
//  Copyright © 2016 Michael Cheng. All rights reserved.
//
// UIKit includes buttons
import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var display: UILabel!
    
    //    the following is inferred to be a bool
    private var userIsInTheMiddleOfTyping=false
    
    //    var userIsInTheMiddleOfTyping: Bool=false
    
    @IBOutlet private weak var history: UILabel!
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
            let textCurrentlyInDisplay=display.text!
            display.text = textCurrentlyInDisplay+digit
        }else{
            display.text=digit
        }
        userIsInTheMiddleOfTyping=true
        
        //        print("touched \(digit) digit")
        
    }
    
    private var displayValue: Double{
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain=CalbulatorBrain()
    
    @IBAction private func performOperation(sender: AnyObject) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle!{
            brain.performOperation(symbol: mathematicalSymbol)
            //                display.text = String(M_PI)
        }
        displayValue=brain.result
        
        
        //            if mathematicalSymbol == "π"{
        //                displayValue = M_PI
        ////                display.text = String(M_PI)
        //            }else if mathematicalSymbol == "√"{
        //                displayValue = sqrt (displayValue)
        //        }
        
        
    }
    
}

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
