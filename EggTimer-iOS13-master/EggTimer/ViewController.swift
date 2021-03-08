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
    
    let eggTimes = ["Soft" : 15.0, "Medium" : 20.0, "Hard" : 5.0]
    var secondsRemaining = 60.0
    var totalTime = 60.0
    var timer = Timer()
    var player: AVAudioPlayer?
    var eggCount = 0
    
    
    @IBOutlet weak var eggHeader: UILabel!
    @IBOutlet weak var eggProgressBar: UIProgressView!
    @IBOutlet weak var timerMessage: UILabel!
    @IBOutlet weak var remainTimeView: UILabel!
    @IBAction func HardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardenss = sender.currentTitle ?? ""
        eggHeader.text = "Your egg is cooking 🥚🥚🥚"
        secondsRemaining = eggTimes[hardenss]!
        totalTime = eggTimes[hardenss]!
        remainTimeView.text = secondsToString(sec: totalTime)
        eggProgressBar.progress = 1.0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

    }
    
    func secondsToString(sec: Double) -> String {
        guard sec.isNaN == false else { return "00:00" }
        let totalSeconds = Int(sec)
        let min = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
    }
    
    @objc func updateTimer() {
        let alert = UIAlertController(title: "EGG TIME", message: "Your egg is Done 😄", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        
        while secondsRemaining > 0  {
            secondsRemaining -= 1
            eggCount = (eggCount%4)+1
            
            let eggconProcess = String(repeating: "🥚", count: eggCount)
            eggHeader.text = "Your egg is cooking \(eggconProcess)"
            
            remainTimeView.text = secondsToString(sec: secondsRemaining)
            eggProgressBar.progress = Float(secondsRemaining/totalTime)
            if secondsRemaining == 0 {
                playSound(key:"C")
//                playSound(key:"E")
//                playSound(key:"G")
                eggHeader.text = "How do you like your eggs?"
                timer.invalidate()m
                present(alert, animated: true, completion: nil)
            } else {return}
        }
        
        
//        if secondsRemaining > 0 {
//            secondsRemaining -= 1
//            remainTimeView.text = secondsToString(sec: secondsRemaining)
//            eggProgressBar.progress = Float(secondsRemaining/totalTime)
//            print("\(secondsRemaining)/\(totalTime)")
//        } else if secondsRemaining == 0 {
//            playSound(key:"alarm_sound")
//            timer.invalidate()
//            present(alert, animated: true, completion: nil)
//            print("done")
//            return
//        }
    }
    
    func playSound(key:String) {
        guard let url = Bundle.main.url(forResource: key, withExtension: "wav") else { return }
         
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
