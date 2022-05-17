//
//  questionViewController.swift
//  iquiz
//
//  Created by Wensi Xu on 5/8/22.
//

import UIKit

class QuestionViewController: UIViewController {
    var quizData : [Quizs] = []
    var indexPathRow = -1
    var questionNum = 0
    var answerSelected = -1
    var correctNum = 0
    
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnC: UIButton!
    @IBOutlet weak var btnD: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
        
    @IBAction func answerSelected(_ sender: UIButton) {
        switch sender.tag {
            case 1:
                answerSelected = 0
                btnA.isSelected = true
                btnB.isSelected = false
                btnC.isSelected = false
                btnD.isSelected = false
            case 2:
                answerSelected = 1
                btnA.isSelected = false
                btnB.isSelected = true
                btnC.isSelected = false
                btnD.isSelected = false
            case 3:
                answerSelected = 2
                btnA.isSelected = false
                btnB.isSelected = false
                btnC.isSelected = true
                btnD.isSelected = false
            case 4:
                answerSelected = 3
                btnA.isSelected = false
                btnB.isSelected = false
                btnC.isSelected = false
                btnD.isSelected = true
            default:
                answerSelected = -1
        }
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        if answerSelected == -1 {
            let alert = UIAlertController(title: "No Response", message: "Please select a answer.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: { _ in
                NSLog("\"OK\" pressed.")
            }))
            self.present(alert, animated: true, completion: {
                NSLog("The completion handler fired")
            })
        } else {
            if let answerVC = storyboard?.instantiateViewController(withIdentifier: "answerVC") as? AnswerViewController {
                answerVC.question = quizData[indexPathRow].questions[questionNum].text
                let corrAnswer = quizData[indexPathRow].questions[questionNum].answer
                switch corrAnswer {
                case "1":
                    answerVC.answer = quizData[indexPathRow].questions[questionNum].answers[0]
                case "2":
                    answerVC.answer = quizData[indexPathRow].questions[questionNum].answers[1]
                case "3":
                    answerVC.answer = quizData[indexPathRow].questions[questionNum].answers[2]
                case "4":
                    answerVC.answer = quizData[indexPathRow].questions[questionNum].answers[3]
                default:
                    print("Error getting answer")
                }
                if answerSelected == Int(corrAnswer)! - 1 {
                    answerVC.message = "Correct!"
                    correctNum += 1
                } else {
                    answerVC.message = "Incorrect!"
                }
                answerVC.totalQuestionNum = quizData[indexPathRow].questions.count
                answerVC.quizData = self.quizData
                answerVC.currentQuestionNum = questionNum
                answerVC.subject = quizData[indexPathRow].title
                answerVC.correctAns = correctNum
                answerVC.indexPathRow = self.indexPathRow
                self.navigationController?.pushViewController(answerVC, animated: true)
            }
        }
    }
    
    @IBAction func backToHome(_ sender: Any) {
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainVC") as? ViewController {
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        questionLabel.text = quizData[indexPathRow].questions[questionNum].text
        btnA.setTitle(quizData[indexPathRow].questions[questionNum].answers[0], for: .normal)
        btnB.setTitle(quizData[indexPathRow].questions[questionNum].answers[1], for: .normal)
        btnC.setTitle(quizData[indexPathRow].questions[questionNum].answers[2], for: .normal)
        btnD.setTitle(quizData[indexPathRow].questions[questionNum].answers[3], for: .normal)

    }

}

extension UIButton {
    open override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.black : UIColor.white
        }
    }
}
