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
        let firstQuestion = allQuestions.list[0]
        questionLabel.text = firstQuestion.questionText
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
        if questionNumber < allQuestions.list.count {
      questionLabel.text = allQuestions.list[questionNumber].questionText
    }
}
    

    func nextQuestion() {
        if questionNumber < allQuestions.list.count{
            questionLabel.text = allQuestions.list[questionNumber].questionText
        } else {
            let alert = UIAlertController(title: "End of Quiz , you got \(correctAnswers) answers correct out of \(allQuestions.list.count)", message: "Quiz Completed.", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
                self.questionLabel.text = "you got \(self.correctAnswers) answers correct out of \(self.allQuestions.list.count)"
                self.viewWithBtns.isHidden = true
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
            print("Correct answer")
            correctAnswers += 1
        }else {
            
            print("Wrong !")
        }
        }
        
    }
    
    
    func startOver() {
       questionNumber = 0
        correctAnswers = 0
        nextQuestion()
    }
    

    
}
