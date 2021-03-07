//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    
    @IBAction func keyPressed(_ sender: UIButton) {
        guard let key = sender.currentTitle else {
            print("No title")
            return
        }
        print(key)
        sender.alpha = 0.5
        playSound(key: key)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
            
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

