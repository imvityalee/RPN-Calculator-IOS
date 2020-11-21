//
//  Model.swift
//  Calculator
//
//  Created by Victor Lee on 9/20/20.
//

import Foundation


class CalculatorModel: CustomStringConvertible {
    
//    var viewer: ViewController?
    
    var stackOp = [Operation]()
    var knownOperations = [String: Operation]()
    enum Operation: CustomStringConvertible {
        case Operand(Double)
        case OperationBinary(String, (Double,  Double) -> Double)
        case OperationUnary (String, (Double) -> Double)
        
        
        var description: String {
            switch self {
            case .Operand(let value):
                return "\(value)"
            case .OperationBinary(let number, _):
                return number
            case .OperationUnary(let number, _ ):
                return number
                
            }
            
        }
    }
    func registredOperand( number: Double ) {
        stackOp.append(Operation.Operand(number))
    }
    
    var description: String {
        return stackOp.description
    }
    

    init() {
        knownOperations["+"] = Operation.OperationBinary("+") {$0+$1}
        knownOperations["-"] = Operation.OperationBinary("-") {$1-$0}
        knownOperations["×"] = Operation.OperationBinary("*") {$0*$1}
        knownOperations["÷"] = Operation.OperationBinary("÷") {$0/$1}
        knownOperations["√"] = Operation.OperationUnary("√") {sqrt($0)}
    }
    
    func apply(operation num: String) {
        if let operation = knownOperations[num] {
            stackOp.append(operation)
        }
    }
    
    func clearScreen(_ sender: Any) {
        stackOp.removeAll()
    }
    
    
    func evaluate( _ operations:[Operation]) -> (Double?, [Operation]) {
        
        if !operations.isEmpty {
            var remainedOperations = operations
            let op = remainedOperations.popLast()!
            switch op {
            case .Operand(let number):
                return(number,remainedOperations)
            case .OperationUnary(_, let operation):
                var (value,resultStack) = evaluate(remainedOperations)
                if let value = value {
                    return (operation(value),remainedOperations)
                } else {
                    return (nil, remainedOperations)
                }
            case .OperationBinary(_, let operation):
                var (value, resultStack) = evaluate(remainedOperations)
                if let value1 = value {
                    (value, resultStack) = evaluate(resultStack)
                    if let value2 = value {
                        return(operation(value1,value2), resultStack)
                    }
                }
                return(nil,resultStack)
            }
        }
        return (nil, operations)
        
    }
    func evaluation() -> Double? {
        let(value, _) = evaluate(stackOp)
        return value
    }
    
    
}
