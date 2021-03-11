//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by JAY LEE on 2021/03/11.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var color : UIColor?
    var advice: String?
    var bmiValue: String? // <---- 바꾸고 싶은데 어떻게 할지
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adviceLabel.text = advice
        view.backgroundColor = color
        bmiLabel.text = bmiValue
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
