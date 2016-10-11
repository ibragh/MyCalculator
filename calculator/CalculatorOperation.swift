//
//  CalculatorOperation.swift
//  calculator
//
//  Created by Ibrahim on 10/4/16.
//  Copyright © 2016 ibragh. All rights reserved.
//

import Foundation


class CalculatorOperation{
    var accumulator = 0.0
    
    func setOperand(opreand: Double){
        accumulator = opreand
    }
    var opreations: Dictionary<String, Opreation> = [
        "cos" : Opreation.UnaryOpreation(cos),
        "sin" : Opreation.UnaryOpreation(sin),
        "π" : Opreation.Constant(M_PI),
        "e" : Opreation.Constant(M_E),
        "√" : Opreation.UnaryOpreation(sqrt),
        "×" : Opreation.BinaryOpreation({ $0 * $1}),
        "+" : Opreation.BinaryOpreation({ $0 + $1}),
        "−" : Opreation.BinaryOpreation({ $0 - $1}),
        "÷" : Opreation.BinaryOpreation({ $0 / $1}),
        "=" : Opreation.Equals,
        "AC" : Opreation.Constant(0.0)
    ]
    enum Opreation {
        case Constant(Double)
        case UnaryOpreation((Double) -> Double)
        case BinaryOpreation((Double,Double) -> Double)
        case Equals
    }
    private var pending: PendingBinaryOpreation?
    
    struct PendingBinaryOpreation {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    func performOperation(symbol: String){
        if let opreation = opreations[symbol] {
            switch opreation {
            case .Constant(let value): accumulator = value
            case .UnaryOpreation(let funct): accumulator = funct(accumulator)
            case .BinaryOpreation(let funct):
                equalOpreation()
                pending = PendingBinaryOpreation(binaryFunction: funct, firstOperand: accumulator)
            case .Equals:
                equalOpreation()
                
            }
        }
    }
    func equalOpreation(){
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }
    }
    var result: Double{
        get{
            return accumulator
        }
    }
    

}
