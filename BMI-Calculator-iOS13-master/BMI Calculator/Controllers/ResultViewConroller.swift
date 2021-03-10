//
//  ResultViewConroller.swift
//  BMI Calculator
//
//  Created by JAY LEE on 2021/03/11.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var bmiValue = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let label = UILabel()
        label.text = "Hello"
        label.frame = CGRect(x: 70, y: 70, width: 100, height: 50)
        view.addSubview(label)
    }
}
