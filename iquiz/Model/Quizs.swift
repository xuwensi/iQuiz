//
//  Quizs.swift
//  iquiz
//
//  Created by Wensi Xu on 5/13/22.
//

import Foundation

struct Quizs: Decodable {
    let title : String
    let desc : String
    let questions : [Question]
}
