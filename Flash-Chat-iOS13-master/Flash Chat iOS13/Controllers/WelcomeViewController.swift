//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel2.alpha = 0
        titleLabel.text = "Welcome to"
        titleLabel2.text = "🔥FireChat"
        
        for n in 1...10 {
            Timer.scheduledTimer(withTimeInterval: 0.07*Double(n), repeats: false) { (timer) in
                self.titleLabel.alpha = CGFloat(n)*0.1
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false) { (timer) in
            for n in 0...10 {
                Timer.scheduledTimer(withTimeInterval: 0.08*Double(n), repeats: false) { (timer) in
                    self.titleLabel.alpha = (10.0-CGFloat(n))*0.1
                }
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.3, repeats: false) { (timer) in
            for n in 0...10 {
                Timer.scheduledTimer(withTimeInterval: 0.08*Double(n), repeats: false) { (timer) in
                    self.titleLabel2.alpha = CGFloat(n)*0.1
                }
            }
        }
        
    }
    
}

