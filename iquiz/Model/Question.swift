//
//  Question.swift
//  iquiz
//
//  Created by Wensi Xu on 5/10/22.
//

import Foundation

class Question {
    let question: String
    let optionA : String
    let optionB : String
    let optionC : String
    let optionD : String
    let correctAnswer : Int
    
    init(question: String, optionA: String, optionB: String, optionC: String, optionD: String, correctAnswer: Int) {
        self.question = question
        self.optionA = optionA
        self.optionB = optionB
        self.optionC = optionC
        self.optionD = optionD
        self.correctAnswer = correctAnswer
    }
}
