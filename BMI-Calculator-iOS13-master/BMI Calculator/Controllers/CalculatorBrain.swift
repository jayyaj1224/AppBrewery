//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by JAY LEE on 2021/03/11.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation

struct CalculatorBrain {

    var bmi: Float = 0.0
    
    func getBMIValue() -> String{
        let bmiString = String(format: "%.1f", bmi)
        return bmiString
    }
    
    mutating func calculateBMI(weight: Float, height: Float) {
        bmi = weight / pow(height, 2)
    }
}

