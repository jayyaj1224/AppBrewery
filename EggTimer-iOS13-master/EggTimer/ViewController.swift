//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft" : 360.0, "Medium" : 420.0, "Hard" : 760.0]
    var secondsRemaining = 60.0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    
    @IBOutlet weak var timerMessage: UILabel!
    @IBOutlet weak var remainTimeView: UILabel!
    @IBAction func HardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardenss = sender.currentTitle ?? ""
        secondsRemaining = eggTimes[hardenss]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

    }
    
    
    
    @objc func updateTimer() {
        let alert = UIAlertController(title: "Message", message: "Your egg is Done.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        
        func secondsToString(sec: Double) -> String {
            guard sec.isNaN == false else { return "00:00" }
            let totalSeconds = Int(sec)
            let min = totalSeconds / 60
            let seconds = totalSeconds % 60
            return String(format: "%02d:%02d", min, seconds)
        }
        
        if secondsRemaining > 0 {
            print("-->>> \(secondsRemaining) seconds")
            secondsRemaining -= 1
            remainTimeView.text = secondsToString(sec: secondsRemaining)
        } else if secondsRemaining == 0 {
            playSound(key:"alarm_sound")
            timer.invalidate()
            present(alert, animated: true, completion: nil)
            print("done")
            return
        }
    }
    
    func playSound(key:String) {

        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
         
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
