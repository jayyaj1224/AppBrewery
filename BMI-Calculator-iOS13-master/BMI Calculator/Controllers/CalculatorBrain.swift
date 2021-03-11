//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by JAY LEE on 2021/03/11.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit
/*
     let bmi = weight / (height*height)
     bmiVale = String(format: "%.1f", bmi)
     
     1. bmi 계산
     2. 계산된 bmi String 으로 변환
     
     */

struct CalculatorBrain {
    
    var bmi : BMI?
    
    
    //<-- MVC refactoring: bmi를 계산하는 Logic
    mutating func howMuchBmi (_ weight: Float, _ height: Float) {
        let bmiValue = weight / (height*height)
        // BMI Structure에서 Value는 let -> 그저 값을 전달하기만 해준다.
        // 따라서 bmi?.value = weight / (height*height) 이렇게 값을 할당해주기보다는
        //bmi = BMI(value: bmiValue, advice: "", color: .red)
        switch bmiValue {
        case 0 ..< 18.5 :
            bmi = BMI(value: bmiValue, advice: "Thin! Eat more pies", color: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        case 18.5 ..< 24.9 :
            bmi = BMI(value: bmiValue, advice: "Normal! Eat more, Workout more", color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        default :
            bmi = BMI(value: bmiValue, advice: "Fat! You're a pathetic pig ^__^", color: #colorLiteral(red: 0.7647058964, green: 0.08861612622, blue: 0, alpha: 1))
        }
    }
    
    //    <-- MVC refactoring: bmi Float를 String으로 바꾸는 Logic
//    func bmiStringize() -> String {
//        let bmiString = String(format: "%.1f", bmi?.value ?? 0.0)
//        return bmiString
//    }
//
//    func getAdvice() -> String {
//        guard let advice = bmi?.advice else { return "fuck off" }
//        return advice
//    }
//
//    func getColor() -> UIColor {
//        let color = bmi?.color ?? .blue
//        return color
//    }
    
    //    func bmiStringize_GuardLet() -> String {
    //        guard let safeBMI = bmi else {
    //        return "0.0"
    //        }
    //        let bmiString = String(format: "%.1f", safeBMI)
    //        return bmiString
    //    }
    //
    //    func bmiStringize_IfLet() -> String {
    //
    //        if let safeBMI = bmi {
    //            let bmiString = String(format: "%.1f", safeBMI)
    //            return bmiString
    //        } else {
    //            return "0.0"
    //        }
    //
    //    }
    //
    //    func bmiStringize_NilCoalescing() -> String {
    //        let safeBMI : Float = bmi ?? 0.0
    //        let bmiString = String(format: "%.1f", safeBMI)
    //        return bmiString
    //    }
    //
    //    func bmiStringize_Force() -> String {
    //        let bmiString = String(format: "%.1f", bmi!)
    //        return bmiString
    //    }
}

