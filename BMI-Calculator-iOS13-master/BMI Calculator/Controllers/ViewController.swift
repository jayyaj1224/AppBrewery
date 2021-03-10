//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        
        let bmi = weight / pow(height, 2)
        print(bmi)
    }
    
}

