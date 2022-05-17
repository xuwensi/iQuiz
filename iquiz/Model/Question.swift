//
//  Question.swift
//  iquiz
//
//  Created by Wensi Xu on 5/10/22.
//

import Foundation

struct Question: Decodable {
    let text : String
    let answer : String
    let answers : [String]

}
