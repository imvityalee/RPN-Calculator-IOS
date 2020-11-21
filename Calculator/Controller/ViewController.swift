//
//  ViewController.swift
//  Calculator
//
//  Created by Victor Lee on 9/20/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var screenLabel: UILabel!
    var decimalPoints = false
    var onTheMiddleNubmer = false
    var stackNumbers : Array<Double> = Array<Double>()
    
    var model = CalculatorModel() 
    
    var output: Double { // outPutLabel Screen
        get {
            onTheMiddleNubmer = false
            decimalPoints = true
            return NumberFormatter().number(from: outputLabel.text!)!.doubleValue
        }
        set {
            outputLabel.text = "\(newValue)"
            onTheMiddleNubmer = false
            decimalPoints = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func numberPressed(_ sender: RoundButton) {
        
        let digits = sender.currentTitle!
        
        if onTheMiddleNubmer  {
            outputLabel.text = outputLabel.text! + digits
        } else {
            outputLabel.text = digits
            onTheMiddleNubmer = true
        }
        
        
    }
    
    @IBAction func allClearPressed(_ sender: RoundButton) {
        
        outputLabel.text = "0"
        onTheMiddleNubmer = false
        model.clearScreen(description)
        displayStack()
        
    }
    
    
    @IBAction func dotPressed(_ sender: RoundButton) {
        if !decimalPoints {
            decimalPoints = true
            if onTheMiddleNubmer {
                outputLabel.text = outputLabel.text! + "."
            } else {
                outputLabel.text = "0."
                onTheMiddleNubmer = true
            }
        }
    }
    
    @IBAction func calculatePressed(_ sender: RoundButton) {
        
        if onTheMiddleNubmer {
            model.registredOperand(number: output)
            onTheMiddleNubmer = false
        }
        model.apply(operation: sender.currentTitle!)
        if let result = model.evaluation() {
            output = result
        }
        
        print("The model is \(model)")
        displayStack()
    }
    
    
    
    /// Press enter to add number to stack
    @IBAction func enterPressed(_ sender: RoundButton) {
        
        if onTheMiddleNubmer {
            model.registredOperand(number: output)
            onTheMiddleNubmer = false
            displayStack()
        }
        
    }
    
    func displayStack() {
        screenLabel.text = model.description
    }
    
    
}





