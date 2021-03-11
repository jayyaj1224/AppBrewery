//
//  ViewController.swift
//  BMI Calculator
//
//  Created by JAY LEE on 2021/03/11.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var calculatorBrain = CalculatorBrain() //<-- MVC refactoring
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let height = String(format: "%.1f", sender.value)
        heightLabel.text = "\(height)cm"
        //print(String(format: "%.2f", sender.value))
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weightLabel.text = String(format: "%.1fkg", sender.value)
        //print(String(format: "%.2f", sender.value))
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heightSlider.value/100
        let weight = weightSlider.value
        
        
        calculatorBrain.howMuchBmi(weight, height)  //<-- MVC refactoring
        
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let resultVC = segue.destination as! ResultViewController
            
            
            resultVC.bmiValue = calculatorBrain.bmiStringize() //<-- MVC refactoring
            
            
        }
        
    }
}
