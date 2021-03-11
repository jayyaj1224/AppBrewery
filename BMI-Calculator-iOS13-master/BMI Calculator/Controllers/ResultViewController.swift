//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by JAY LEE on 2021/03/11.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

//    var color : UIColor?
//    var advice: String?
//    var bmiValue: String? // <---- 바꾸고 싶은데 어떻게 할지
    var userBMIInfo : BMI?
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adviceLabel.text = userBMIInfo?.advice
        view.backgroundColor = userBMIInfo?.color
        bmiLabel.text = String(format: "%.1f", userBMIInfo?.value ?? 0.0)
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
