//
//  answerViewController.swift
//  iquiz
//
//  Created by Wensi Xu on 5/9/22.
//

import UIKit

class AnswerViewController: UIViewController {
    var subject = ""
    var question = ""
    var answer = ""
    var message = ""
    var currentQuestionNum = -1
    var totalQuestionNum = 0
    var correctAns = 0

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBAction func nextQuestion(_ sender: Any) {
        if currentQuestionNum == totalQuestionNum - 1 {
            if let finishVC = storyboard?.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController {
                finishVC.correctNum = correctAns
                finishVC.totalNum = totalQuestionNum
                self.navigationController?.pushViewController(finishVC, animated: true)
            }
        } else {
            if let questionVC = storyboard?.instantiateViewController(withIdentifier: "questionVC") as? QuestionViewController {
                questionVC.questionNum = currentQuestionNum + 1
                questionVC.quizTitle = subject
                questionVC.answerSelected = -1
                questionVC.correctNum = correctAns
                self.navigationController?.pushViewController(questionVC, animated: true)
            }
        }
    }
    
    @IBAction func backtoHome(_ sender: Any) {
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainVC") as? ViewController {
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        questionLabel.text = question
        answerLabel.text = answer
        messageLabel.text = message
        print(correctAns)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
