//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer = false
    var questionNumber : Int = 0
    var correctAnswers : Int = 0
    
    @IBOutlet weak var viewWithBtns: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
            
        } else if sender.tag == 2{
            pickedAnswer = false
            
        }
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }
    
    
    func updateUI() {
      scoreLabel.text = String(describing: correctAnswers)
        progressLabel.text = "\(questionNumber + 1)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
}
    

    func nextQuestion() {
        if questionNumber < allQuestions.list.count{
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            scoreLabel.text = String(describing: correctAnswers)
            let alert = UIAlertController(title: "End of Quiz , you got \(correctAnswers) answers correct out of \(allQuestions.list.count)", message: "Quiz Completed.", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
                self.questionLabel.text = "you got \(self.correctAnswers) answers correct out of \(self.allQuestions.list.count)"
                self.viewWithBtns.isHidden = true
                self.progressLabel.isHidden = true
                self.scoreLabel.isHidden = true
                self.progressBar.isHidden = true
            }
            alert.addAction(restartAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    func checkAnswer() {
        if questionNumber < allQuestions.list.count{
       let correctAnswer = allQuestions.list[questionNumber].answer
       
        if correctAnswer == pickedAnswer {
            if questionNumber != allQuestions.list.count - 1 {
//            ProgressHUD.showSuccess("Correct !")
            let alert = UIAlertController(title: "Correct", message: "the correct answer is : \(correctAnswer)" , preferredStyle: .alert)
            self.present(alert, animated: true, completion: {Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
                self.dismiss(animated: true, completion: nil)
            })})
            correctAnswers += 1
            
            } else {
                correctAnswers += 1
            }
        }else {
            if questionNumber != allQuestions.list.count - 1 {
//            ProgressHUD.showError("Wrong !")
            let alert = UIAlertController(title: "false", message: "the correct answer is : \(correctAnswer)" , preferredStyle: .alert)
            self.present(alert, animated: true, completion: {Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
                self.dismiss(animated: true, completion: nil)
            })})

        }
        }
        }
        
    }
    
    
    func startOver() {
       questionNumber = 0
        correctAnswers = 0
        nextQuestion()
        scoreLabel.text = "0"
    }
    

    
}
