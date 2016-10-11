//
//  ViewController.swift
//  calculator
//
//  Created by Ibrahim on 10/4/16.
//  Copyright © 2016 ibragh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var userIsTyping = false
    // get the displayed current value
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set{
            //newValue is the set value from here ^
            display.text = String(newValue)
        }
    }
    
    @IBOutlet private weak var display: UILabel!
    
    @IBAction private func touchDigit(_ sender: AnyObject) {
        
        let digit = sender.currentTitle!
        print(digit)
        
        if userIsTyping {
            let textCurrntlyInDisplay = display.text!
            display.text = textCurrntlyInDisplay + digit!
        } else {
            display.text = digit!
            
        }
        userIsTyping = true
    }
    
    private var calculator = CalculatorOperation()
    
    @IBAction private func calculate(_ sender: AnyObject) {
        
        if userIsTyping {
            calculator.setOperand(opreand: displayValue)
            userIsTyping = false
        }
        if let mathSymbole = sender.currentTitle {
            calculator.performOperation(symbol: mathSymbole!)
        }
        displayValue = calculator.result
        
        /*
         if let mathSymbole = sender.currentTitle! {
         if mathSymbole == "π" {
         displayValue = M_PI
         } else if mathSymbole == "√" {
         displayValue = sqrt(displayValue)
         }
         }
         */
    }
    
    
    
    
}

