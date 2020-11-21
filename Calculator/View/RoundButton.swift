//
//  RoundButton.swift
//  Calculator
//
//  Created by Victor Lee on 9/20/20.
//

import UIKit



@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var roundButton: Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }

    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }
    
    
}
