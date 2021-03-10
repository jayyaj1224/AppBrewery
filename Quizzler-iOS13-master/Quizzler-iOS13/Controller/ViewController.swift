//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var finalScoreView: UIView!
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalScoreView.alpha = 0
        updateUI()
    }
    
    @IBAction func answerButtonClicked(_ sender: UIButton) {
        guard let userAnswer = sender.currentTitle else {return}
        let userGotItRight = quizBrain.checkAnwer(userAnswer)
        
        if userGotItRight {
            sender.backgroundColor = UIColor.blue
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        if quizBrain.quizIndex + 1 < quizBrain.quiz.count {
            quizBrain.nextQuestion()
            perform(#selector(updateUI), with: self, afterDelay: 0.3)
        } else {
            perform(#selector(finalScoreViewLoad), with: self, afterDelay: 0.3)
        }
        
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        questionNumber.text = "Question Number: \(String(quizBrain.quizIndex+1)) / \(String(quizBrain.quiz.count))"
        scoreLabel.text = "Score: \(quizBrain.getScore()) / \(quizBrain.quiz.count)"
        progressBar.progress = quizBrain.getProgress()
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
    }
    
    @objc func finalScoreViewLoad(){
        finalScoreView.alpha = 1
        finalScoreLabel.text = "Score: \(quizBrain.getScore()) / \(quizBrain.quiz.count)"
        updateUI()
    }
    
    @IBAction func restartButtonClicked(_ sender: UIButton) {
        finalScoreView.alpha = 0
        quizBrain.quizReset()
        updateUI()
    }
    

}
    




