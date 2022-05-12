//
//  questionViewController.swift
//  iquiz
//
//  Created by Wensi Xu on 5/8/22.
//

import UIKit

class QuestionViewController: UIViewController {
    var quizTitle = ""
    var questionNum = 0
    var answerSelected = -1
    var correctNum = 0
    
    // Math
    let mathQuestions : [Question] = [Question(question: "What is two fifth of 100?", optionA: "10", optionB: "20", optionC: "40", optionD: "60", correctAnswer: 2),
                                      Question(question: "If Kevin’s age is 20 years old in 2011. What was his age in 2003?", optionA: "11", optionB: "12", optionC: "13", optionD: "14", correctAnswer: 1),
                                      Question(question: "The sum of squares of two numbers is 80 and the square of difference between the two numbers is 36. Find the product of two numbers.", optionA: "11", optionB: "22", optionC: "26", optionD: "33", correctAnswer: 1),
                                      Question(question: "Which number is neither prime nor composite?", optionA: "3", optionB: "2", optionC: "0", optionD: "1", correctAnswer: 3),
                                      Question(question: "How many diagonals are there in a quadrilateral?", optionA: "2", optionB: "3", optionC: "4", optionD: "None", correctAnswer: 0)]
    
    // Marvel
    let marvelQuestions : [Question] = [Question(question: "What is Captain America’s shield made of?", optionA: "Adamantium", optionB: "Vibranium", optionC: "Promethium", optionD: "Carbonadium", correctAnswer: 1),
                                        Question(question: "Before becoming Vision, what is the name of Iron Man’s A.I. butler?", optionA: "H.O.M.E.R.", optionB: "J.A.R.V.I.S.", optionC: "A.L.F.R.E.D.", optionD: "M.A.R.V.I.N.", correctAnswer: 1),
                                        Question(question: "What is the real name of the Black Panther?", optionA: "T’Challa", optionB: "M’Baku", optionC: "N’Jadaka", optionD: "N’Jobu", correctAnswer: 0),
                                        Question(question: "What does the Winter Soldier say after Steve recognizes him for the first time?", optionA: "Do I know you?", optionB: "What did you say?", optionC: "He’s gone.", optionD: "Who the hell is Bucky?", correctAnswer: 3),
                                        Question(question: "Who is killed by Loki in the Avengers?", optionA: "Maria Hill", optionB: "Nick Fury", optionC: "Agent Coulson", optionD: "Doctor Erik Selvig", correctAnswer: 2)]
    
    // Science
    let scienceQuestions : [Question] = [Question(question: "What percent of fire-related deaths are due to smoke inhalation rather than burns?", optionA: "10%", optionB: "50%", optionC: "80%", optionD: "99%", correctAnswer: 2),
                                         Question(question: "The fastest-running terrestrial animal is:", optionA: "cheetah", optionB: "lion", optionC: "man", optionD: "jaguar", correctAnswer: 0),
                                         Question(question: "Bees must collect nectar from approximately how many flowers to make 1 pound of honeycomb?", optionA: "2 million", optionB: "10 thousand", optionC: "20 million", optionD: "50 million", correctAnswer: 2),
                                         Question(question: "The branch of medical science which is concerned with the study of disease as it affects a community of people is called: ", optionA: "oncology", optionB: "epidemiology", optionC: "paleontogy", optionD: "pathology", correctAnswer: 1),
                                         Question(question: "What substance was used as a moderator for the chain reaction in the first nuclear reactor?", optionA: "graphite", optionB: "boron", optionC: "water", optionD: "cadmium", correctAnswer: 0)]
    
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
                
                if quizTitle == "Mathematics" {
                    answerVC.question = mathQuestions[questionNum].question
                    let corrAnswer = mathQuestions[questionNum].correctAnswer
                    switch corrAnswer {
                    case 0:
                        answerVC.answer = mathQuestions[questionNum].optionA
                    case 1:
                        answerVC.answer = mathQuestions[questionNum].optionB
                    case 2:
                        answerVC.answer = mathQuestions[questionNum].optionC
                    case 3:
                        answerVC.answer = mathQuestions[questionNum].optionD
                    default:
                        print("Error getting answer")
                    }
                    if answerSelected == corrAnswer {
                        answerVC.message = "Correct!"
                        correctNum += 1
                    } else {
                        answerVC.message = "Incorrect!"
                    }
                    answerVC.totalQuestionNum = mathQuestions.count
                } else if quizTitle == "Marvel Super Heroes" {
                    answerVC.question = marvelQuestions[questionNum].question
                    let corrAnswer = marvelQuestions[questionNum].correctAnswer
                    switch corrAnswer {
                    case 0:
                        answerVC.answer = marvelQuestions[questionNum].optionA
                    case 1:
                        answerVC.answer = marvelQuestions[questionNum].optionB
                    case 2:
                        answerVC.answer = marvelQuestions[questionNum].optionC
                    case 3:
                        answerVC.answer = marvelQuestions[questionNum].optionD
                    default:
                        print("Error getting answer")
                    }
                    if answerSelected == corrAnswer {
                        answerVC.message = "Correct!"
                        correctNum += 1
                    } else {
                        answerVC.message = "Incorrect!"
                    }
                    answerVC.totalQuestionNum = marvelQuestions.count
                } else if quizTitle == "Science" {
                    answerVC.question = scienceQuestions[questionNum].question
                    let corrAnswer = scienceQuestions[questionNum].correctAnswer
                    switch corrAnswer {
                    case 0:
                        answerVC.answer = scienceQuestions[questionNum].optionA
                    case 1:
                        answerVC.answer = scienceQuestions[questionNum].optionB
                    case 2:
                        answerVC.answer = scienceQuestions[questionNum].optionC
                    case 3:
                        answerVC.answer = scienceQuestions[questionNum].optionD
                    default:
                        print("Error getting answer")
                    }
                    if answerSelected == corrAnswer {
                        answerVC.message = "Correct!"
                        correctNum += 1
                    } else {
                        answerVC.message = "Incorrect!"
                    }
                    answerVC.totalQuestionNum = scienceQuestions.count
                }
                answerVC.currentQuestionNum = questionNum
                answerVC.subject = quizTitle
                answerVC.correctAns = correctNum
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

        switch quizTitle {
        case "Mathematics":
            questionLabel.text = mathQuestions[questionNum].question
            btnA.setTitle(mathQuestions[questionNum].optionA, for: .normal)
            btnB.setTitle(mathQuestions[questionNum].optionB, for: .normal)
            btnC.setTitle(mathQuestions[questionNum].optionC, for: .normal)
            btnD.setTitle(mathQuestions[questionNum].optionD, for: .normal)
        case "Marvel Super Heroes":
            questionLabel.text = marvelQuestions[questionNum].question
            btnA.setTitle(marvelQuestions[questionNum].optionA, for: .normal)
            btnB.setTitle(marvelQuestions[questionNum].optionB, for: .normal)
            btnC.setTitle(marvelQuestions[questionNum].optionC, for: .normal)
            btnD.setTitle(marvelQuestions[questionNum].optionD, for: .normal)
        case "Science":
            questionLabel.text = scienceQuestions[questionNum].question
            btnA.setTitle(scienceQuestions[questionNum].optionA, for: .normal)
            btnB.setTitle(scienceQuestions[questionNum].optionB, for: .normal)
            btnC.setTitle(scienceQuestions[questionNum].optionC, for: .normal)
            btnD.setTitle(scienceQuestions[questionNum].optionD, for: .normal)
        default:
            print("Incorrect category")
        }
    }

}

extension UIButton {
    open override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.black : UIColor.white
        }
    }
}
