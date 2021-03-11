//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by JAY LEE on 2021/03/11.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
/*
     let bmi = weight / (height*height)
     bmiVale = String(format: "%.1f", bmi)
     
     1. bmi 계산
     2. 계산된 bmi String 으로 변환
     
     */

struct CalculatorBrain {
    
    var bmi : Float?
    
    
    //<-- MVC refactoring: bmi를 계산하는 Logic
    mutating func howMuchBmi (_ weight: Float, _ height: Float) {
        bmi = weight / (height*height)
    }
    
    //<-- MVC refactoring: bmi Float를 String으로 바꾸는 Logic
    func bmiStringize() -> String {
        let bmiString = String(format: "%.1f", bmi!)
        return bmiString
    }
}

